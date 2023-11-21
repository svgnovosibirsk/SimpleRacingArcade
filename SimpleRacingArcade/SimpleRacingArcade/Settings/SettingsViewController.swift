//
//  SettingsViewController.swift
//  SimpleRacingArcade
//
//  Created by Sergey on 21.11.2023.
//

import UIKit

final class SettingsViewController: UIViewController {

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.settingsScreenTitle
        view.backgroundColor = .systemYellow
    }
}
