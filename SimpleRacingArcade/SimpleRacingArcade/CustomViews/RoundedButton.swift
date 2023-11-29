//
//  RoundedButton.swift
//  SimpleRacingArcade
//
//  Created by Sergey on 21.11.2023.
//

import UIKit

extension UIButton {
    class func roundedButton(title: String, color: UIColor) -> UIButton {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius20
        button.layer.borderColor = color.cgColor
        button.layer.borderWidth = Constants.borderWidth2
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.fontSize20)
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.setTitleColor(.systemGray2, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: Constants.width200).isActive = true
        button.heightAnchor.constraint(equalToConstant: Constants.height80).isActive = true
        return button
    }
    
    class func controlButton(withTitle title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.systemGray2, for: .highlighted)
        button.backgroundColor = UIColor(white: 0, alpha: 0.4)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

