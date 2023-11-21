//
//  FirstScreenViewController.swift
//  SimpleRacingArcade
//
//  Created by Sergey on 21.11.2023.
//

import UIKit

final class FirstScreenViewController: UIViewController {
    
    //MARK: - Properties
    let stackView = UIStackView()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupStackView()
        setupButtons()
    }
    
    //MARK: - Flow
    // MARK: - Buttons
    private func setupButtons() {
        let startButton = UIButton.roundedButton(title: Constants.titleStart, color: .systemRed)
        startButton.addTarget(self, action: #selector(startButtonDidPress), for: .touchUpInside)
        
        let settingsButton = UIButton.roundedButton(title: Constants.titleSettings, color: .systemYellow)
        settingsButton.addTarget(self, action: #selector(settingsButtonDidPress), for: .touchUpInside)
        
        let recordsButton = UIButton.roundedButton(title: Constants.titleRecords, color: .systemGreen)
        recordsButton.addTarget(self, action: #selector(recordsButtonDidPress), for: .touchUpInside)
        
        stackView.addArrangedSubview(startButton)
        stackView.addArrangedSubview(settingsButton)
        stackView.addArrangedSubview(recordsButton)
    }
    
    @objc func startButtonDidPress() {
        //TODO: Implement
        print(#function)
    }
    
    @objc func settingsButtonDidPress() {
        //TODO: Implement
        print(#function)
    }
    
    @objc func recordsButtonDidPress() {
        //TODO: Implement
        print(#function)
    }
    
    // MARK: - Stack View
    func setupStackView() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = Constants.spacing20
        stackView.layer.cornerRadius = Constants.cornerRadius10
        stackView.layoutMargins = UIEdgeInsets(top: Constants.edgeInsets10,
                                               left: Constants.edgeInsets10,
                                               bottom: Constants.edgeInsets10,
                                               right: Constants.edgeInsets10)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        setupStackViewConstraints()
    }
    
    func setupStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                               constant: Constants.constraint20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                constant: Constants.constraintMinus20),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

