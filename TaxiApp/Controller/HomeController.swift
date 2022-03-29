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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
//        signOut()
    }
    
    // MARK: - Helper functions
    
    func setupView() {
        view.backgroundColor = .red
        view.addSubview(mapView)
                
        setUpConstraints()
    }
    
    func setUpConstraints() {
        mapView.frame = view.frame

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
