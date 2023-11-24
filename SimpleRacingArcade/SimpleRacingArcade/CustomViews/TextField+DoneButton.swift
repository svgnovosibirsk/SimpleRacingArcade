//
//  TextField+DoneButton.swift
//  SimpleRacingArcade
//
//  Created by Sergey on 22.11.2023.
//

import UIKit

extension UITextField {
    func addDoneButton(title: String, target: Any, selector: Selector) {
        self.inputAccessoryView = creareToolbarWithButton(title: title, target: target, selector: selector)
    }
    
    private func creareToolbarWithButton(title: String, target: Any, selector: Selector) -> UIToolbar {
        let toolBar = UIToolbar(frame: CGRect(x: .zero,
                                              y: .zero,
                                              width: UIScreen.main.bounds.size.width,
                                              height: Constants.height44))
        toolBar.barStyle = .black
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
        toolBar.setItems([flexible, barButton], animated: false)
        return toolBar
    }
}
