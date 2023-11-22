//
//  SettingsViewController.swift
//  SimpleRacingArcade
//
//  Created by Sergey on 21.11.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    //MARK: - Properties
    private let stackView = UIStackView()
    private let nameLabel = UILabel.largeFontLabel(withText: Constants.nameText)
    private let photoLabel = UILabel.largeFontLabel(withText: Constants.photoText)

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.settingsScreenTitle
        view.backgroundColor = .systemYellow
        setupScreen()
    }
    
    //MARK: Flow
    private func setupScreen() {
        setupStackView()
        setupNameLabel()
        setupPhotoLabel()
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        stackView.backgroundColor = .systemYellow
        stackView.isLayoutMarginsRelativeArrangement = true
        
        setupStackViewConstraints()
    }
    
    private func setupStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupNameLabel() {
        stackView.addArrangedSubview(nameLabel)
    }
    
    private func setupPhotoLabel() {
        stackView.addArrangedSubview(photoLabel)
    }
}
