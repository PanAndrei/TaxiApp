//
//  LocationInputActionView.swift
//  TaxiApp
//
//  Created by Andrei Panasenko on 30.03.2022.
//

import UIKit

protocol LocationInputActivationViewDelegate: class {
    func presentLocationInputView()
}

class LocationInputActivationView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: LocationInputActivationViewDelegate?

    private let inicatiorView: UIView = {
       let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Where to"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .darkGray
        return label
    }()
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers
    
    func setupView() {
        backgroundColor = .white
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.55
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        layer.masksToBounds = false
        
        addSubview(inicatiorView)
        addSubview(placeholderLabel)
        
        setupConstraints()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentLocationInputView))
        addGestureRecognizer(tap)
    }
    
    func setupConstraints() {
        inicatiorView.centerY(inView: self, leftAncor: leftAnchor, paddingLeft: 16)
        inicatiorView.setDimensions(height: 6, width: 6)
        
        placeholderLabel.centerY(inView: self, leftAncor: inicatiorView.rightAnchor, paddingLeft: 20)
    }
    
    // MARK: - Selectors
    
    @objc func presentLocationInputView() {
        delegate?.presentLocationInputView()
    }
}
