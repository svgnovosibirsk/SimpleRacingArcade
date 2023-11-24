//
//  LargeFontLabel.swift
//  SimpleRacingArcade
//
//  Created by Sergey on 22.11.2023.
//

import UIKit

extension UILabel {
    class func largeFontLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: Constants.fontSize20)
        return label
    }
}
