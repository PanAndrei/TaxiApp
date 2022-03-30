//
//  HomeController.swift
//  TaxiApp
//
//  Created by Andrei Panasenko on 28.03.2022.
//

import UIKit
import Firebase
import MapKit

class HomeController: UIViewController {
    
    // MARK: - Properties
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    private let locationActivationView = LocationInputActivationView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIfUserIsLoggedIn()
        enableLotionServices()
//        signOut()
    }
    
    // MARK: - Helper functions
    
    func setupView() {
        view.backgroundColor = .backgroundColor

        configureMapView()
        
        view.addSubview(locationActivationView)
        locationActivationView.alpha = 0
        locationActivationView.delegate = self
        UIView.animate(withDuration: 2) {
            self.locationActivationView.alpha = 1
        }
        
        setupConstraints()
    }
    
    func setupConstraints() {
        locationActivationView.centerX(inView: view)
        locationActivationView.setDimensions(height: 50, width: view.frame.width - 64)
        locationActivationView.anchor(top: view.safeAreaLayoutGuide.topAnchor, padddingTop: 32)
    }
    
    func configureMapView() {
        view.addSubview(mapView)
        mapView.frame = view.frame

        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
    // MARK: - Selectors
    
    // MARK: - API
    
    func checkIfUserIsLoggedIn() {
        if let uid = Auth.auth().currentUser?.uid {
          setupView()
          print("DEBUG: \(uid)")
        } else {
          DispatchQueue.main.async {
            let navigationController = UINavigationController(rootViewController: LoginController())
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true) {
              self.setupView()
            }
          }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out")
        }
    }
    
}

// MARK: - LocationServices

extension HomeController: CLLocationManagerDelegate {
    func enableLotionServices() {
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            print("not determined")
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways:
            print("auth always")
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse:
            print("auth when in use")
            locationManager.requestAlwaysAuthorization()
        @unknown default:
            break
        }
    }
    
    internal func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    
        if status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
    }
}

extension HomeController: LocationInputActivationViewDelegate {
    func presentLocationInputView() {
        print("delegate works")
    }
}
