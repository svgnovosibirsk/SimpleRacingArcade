//
//  GameViewController.swift
//  SimpleRacingArcade
//
//  Created by Sergey on 21.11.2023.
//

import UIKit

final class GameViewController: UIViewController {

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.gameScreenTitle
        view.backgroundColor = .systemRed
    }
}
