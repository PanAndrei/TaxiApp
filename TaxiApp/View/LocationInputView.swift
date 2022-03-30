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
        
        setupConstraints()
    }
    
    func setupConstraints() {
        backButton.anchor(top: topAnchor, left: leftAnchor, padddingTop: 44, paddingLeft: 12, width: 24, height: 25)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Selectors
    
    @objc func handleBackTapped() {
        delegate?.dismissLocationInputView()
    }

}
