//
//  LocationInputView.swift
//  TaxiApp
//
//  Created by Andrei Panasenko on 30.03.2022.
//

import UIKit

protocol LocationInputViewDelegate: class {
    func dismissLocationInputView()
}

class LocationInputView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: LocationInputViewDelegate?
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrowshape.turn.up.left.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Andrey Panasenko"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    // change to layer
    
    private let startLocationIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let linkingView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    private let destinationIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    // refactor to one
    private lazy var startingLocationTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Current location"
        tf.backgroundColor = .groupTableViewBackground
        tf.isEnabled = false
        tf.font = UIFont.systemFont(ofSize: 14)
        
        let paddingView = UIView()
        paddingView.setDimensions(height: 30, width: 8)
        tf.leftView = paddingView
        tf.leftViewMode = .always
        
        return tf
    }()
    
    private lazy var destinationLocationTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Destination location"
        tf.backgroundColor = .lightGray
        tf.returnKeyType = .search
        tf.font = UIFont.systemFont(ofSize: 14)
        
        let paddingView = UIView()
        paddingView.setDimensions(height: 30, width: 8)
        tf.leftView = paddingView
        tf.leftViewMode = .always
        
        return tf
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    // MARK: - Helpers
    
    func setupView() {
        backgroundColor = .white
        addShadow()
        
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(startingLocationTextField)
        addSubview(destinationLocationTextField)
        addSubview(startLocationIndicatorView)
        addSubview(destinationIndicatorView)
        addSubview(linkingView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        backButton.anchor(top: topAnchor, left: leftAnchor, padddingTop: 44, paddingLeft: 12, width: 24, height: 25)
        
        titleLabel.centerY(inView: backButton)
        titleLabel.centerX(inView: self)
        
        startingLocationTextField.anchor(top: backButton.bottomAnchor, left: leftAnchor, right: rightAnchor,
                                         padddingTop: 4, paddingLeft: 40, paddingRight: 40, height: 30)
        
        destinationLocationTextField.anchor(top: startingLocationTextField.bottomAnchor, left: leftAnchor, right: rightAnchor,
                                            padddingTop: 12, paddingLeft: 40, paddingRight: 40, height: 30)
        
        startLocationIndicatorView.centerY(inView: startingLocationTextField, leftAncor: leftAnchor, paddingLeft: 20)
        startLocationIndicatorView.setDimensions(height: 6, width: 6)
        startLocationIndicatorView.layer.cornerRadius = 6 / 2
        
        destinationIndicatorView.centerY(inView: destinationLocationTextField, leftAncor: leftAnchor, paddingLeft: 20)
        destinationIndicatorView.setDimensions(height: 6, width: 6)
        
        linkingView.centerX(inView: startLocationIndicatorView)
        linkingView.anchor(top: startLocationIndicatorView.bottomAnchor, bottom: destinationIndicatorView.topAnchor,
                           padddingTop: 4, paddingBottom: 4, width: 0.5)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleBackTapped() {
        delegate?.dismissLocationInputView()
    }
}
