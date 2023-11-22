//
//  SettingsViewController.swift
//  SimpleRacingArcade
//
//  Created by Sergey on 21.11.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    //MARK: - Constants
    private enum LocalConstants {
        static let nameLabelPlaceholder = "Enter your name"
    }
    
    //MARK: - Properties
    private let stackView = UIStackView()
    private let nameLabel = UILabel.largeFontLabel(withText: Constants.nameText)
    private let photoLabel = UILabel.largeFontLabel(withText: Constants.photoText)
    private let nameTextField = UITextField()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.settingsScreenTitle
        view.backgroundColor = .systemYellow
        setupScreen()
        setupDismissKeyboardGestureRecognizer()
    }
    
    //MARK: Flow
    private func setupScreen() {
        setupStackView()
        setupNameLabel()
        setupNameTextField()
        setupPhotoLabel()
    }
    
    //MARK: Stack
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = Constants.spacing20
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
    
    //MARK: Labels
    private func setupNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(nameLabel)
    }
    
    private func setupPhotoLabel() {
        photoLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(photoLabel)
    }
    
    //MARK: TextField
    private func setupNameTextField() {
        nameTextField.placeholder = LocalConstants.nameLabelPlaceholder
        nameTextField.backgroundColor = .systemYellow
        nameTextField.layer.cornerRadius = Constants.cornerRadius10
        nameTextField.layer.borderColor = UIColor.black.cgColor
        nameTextField.layer.borderWidth = Constants.borderWidth2
        nameTextField.font = UIFont.systemFont(ofSize: Constants.fontSize20)
        addNameTextFieldPadding()
        nameTextField.addDoneButton(title: Constants.doneText,
                                    target: self,
                                    selector: #selector(tapDone(sender:)))
        nameTextField.clearButtonMode = .whileEditing
        setupNameTextFieldConstraints()
    }
    
    private func setupNameTextFieldConstraints() {
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(nameTextField)
        
        NSLayoutConstraint.activate([
            nameTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor,
                                                   constant: Constants.constraint20),
            nameTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,
                                                    constant: Constants.constraintMinus20),
            nameTextField.heightAnchor.constraint(equalToConstant: Constants.constraint50)
        ])
    }
    
    private func addNameTextFieldPadding() {
        let paddingView = UIView(frame: CGRect(x: .zero,
                                               y: .zero,
                                               width: Constants.constraint10,
                                               height: Constants.constraint50))
        nameTextField.leftView = paddingView
        nameTextField.leftViewMode = .always
    }
    
    //MARK: Keyboard handling
    @objc func tapDone(sender: Any) {
           self.view.endEditing(true)
    }
    
    private func setupDismissKeyboardGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func dismissKeyboard(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
