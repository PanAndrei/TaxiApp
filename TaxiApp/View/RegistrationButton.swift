//
//  RegistrationButton.swift
//  TaxiApp
//
//  Created by Andrei Panasenko on 28.03.2022.
//

import UIKit

class RegistrationButton: UIButton {
    
    init(firstPhrase: String, secondPhrase: String) {
        super.init(frame: .zero)
        let attributedTitle = NSMutableAttributedString(string: firstPhrase, attributes: [
            NSMutableAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
            NSMutableAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: secondPhrase, attributes: [
            NSMutableAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
            NSMutableAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
        
        setAttributedTitle(attributedTitle, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
