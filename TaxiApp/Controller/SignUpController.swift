//
//  SignUpController.swift
//  TaxiApp
//
//  Created by Andrei Panasenko on 27.03.2022.
//

import UIKit
import Firebase

class SignUpController: UIViewController {
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Taxi"
        label.font = UIFont(name: "Avenir-Light", size: 36)
        label.textColor = UIColor(white: 1, alpha: 0.8)
        return label
    }()
    // first letter from small
    private lazy var emailContainerView: UIView = {
        let view = UIView().inputContainerView(image: "envelope", textField: emailTextField)
        view.anchor(height: 50)
        return view
    }()
    
    private lazy var fullnameContainerView: UIView = {
        let view = UIView().inputContainerView(image: "person", textField: fullnameTextField)
        view.anchor(height: 50)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView().inputContainerView(image: "lock", textField: passwordTextField)
        view.anchor(height: 50)
        return view
    }()
    
    private let emailTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Email",
                                       isSecureText: false)
    }()
    
    private let fullnameTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Fullname",
                                       isSecureText: false)
    }()
    
    private let passwordTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Password",
                                       isSecureText: true)
    }()
    
    private lazy var acountTypeContainerView: UIView = {
        let view = UIView().inputContainerView(image: "person.crop.square.fill", segmentedControl: accountTypeSegmentControl)
        view.anchor(height: 80)
        return view
    }()
    // white text
    private let accountTypeSegmentControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Rider", "Driver"])
        sc.backgroundColor = .backgroundColor
        sc.tintColor = UIColor(white: 1, alpha: 0.8)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    private let signButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    private let alreadyHaveHaveAccountButton: UIButton = {
        let button = RegistrationButton(firstPhrase: "Already have an account?  ", secondPhrase: "Sign Up")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   fullnameContainerView,
                                                   passwordContainerView,
                                                   acountTypeContainerView,
                                                   signButton])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 24
        return stack
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    // MARK: - Helper functions
    
    func setUpView() {
        view.backgroundColor = .backgroundColor
        
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        view.addSubview(alreadyHaveHaveAccountButton)
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)
        
        stackView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                         padddingTop: 40, paddingLeft: 16, paddingRight: 16)
        
        alreadyHaveHaveAccountButton.centerX(inView: view)
        alreadyHaveHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
    }
    
    // MARK: - Selectors
    
    @objc func handleSignUp() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullnameTextField.text else { return }
        let accountTypeIndex = accountTypeSegmentControl.selectedSegmentIndex
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Failed to register user with error \(error.localizedDescription)")
                return
            }
            
            guard let uid = result?.user.uid else { return }
            
            let values = ["email" : email,
                          "fullname" : fullname,
                          "AccountType" : accountTypeIndex] as [String : Any]
            
            Database.database().reference().child("users").child(uid).updateChildValues(values) { (error, ref) in
                print("Successfully registered used and saved data")
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
}
