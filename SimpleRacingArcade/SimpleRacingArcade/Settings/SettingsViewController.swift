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
        static let imagePlaceholderName = "person"
        static let saveTitle = "Save"
        static let selectedCarSegment = 1
        static let selectedSegmentWhite: CGFloat = 0
        static let selectedSegmentAlfa = 0.2
    }
    
    //MARK: - Properties
    private let stackView = UIStackView()
    private let segmentedControlsStackView = UIStackView()
    private let nameLabel = UILabel.largeFontLabel(withText: Constants.nameText)
    private let photoLabel = UILabel.largeFontLabel(withText: Constants.photoText)
    private let nameTextField = UITextField()
    private let playerImageView = UIImageView()
    private let carSegmentedControl = UISegmentedControl(items: Car.cars())
    private let obstaclesSegmentedControl = UISegmentedControl(items: Obstacle.obstacles())
    private let speedSegmentedControl = UISegmentedControl(items: Speed.speedOptions())
    private let saveButton = UIButton.roundedButton(title: LocalConstants.saveTitle, color: .black)
    private var tapGestureRecognizer: UITapGestureRecognizer?

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GameState.fetchState()
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
        setupPlayerImageView()
        setupSegmentedControlsStackView()
        setupCarSegmentedControl()
        setupObstaclesSegmentedControl()
        setupSpeedSegmentedControl()
        setupSaveButton()
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
        nameTextField.text = GameState.player.name
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
    
    //MARK: ImageView
    private func setupPlayerImageView()  {
        let placeholderImage = UIImage(
            systemName: LocalConstants.imagePlaceholderName
        )?.imageWith(newSize: CGSize(width: Constants.width200,
                                     height: Constants.width200))
        
        playerImageView.image = GameState.player.image ?? placeholderImage
        playerImageView.tintColor = .black
        playerImageView.layer.borderColor = UIColor.black.cgColor
        playerImageView.layer.borderWidth = Constants.borderWidth2
        playerImageView.layer.cornerRadius = Constants.cornerRadius20
        playerImageView.clipsToBounds = true
        playerImageView.contentMode = .scaleAspectFit
        playerImageView.isUserInteractionEnabled = true
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(playerImageViewDidTap(_:)))
        playerImageView.addGestureRecognizer(tapGestureRecognizer!)
        
        setPlayerImageViewConstaraints()
    }
    
    @objc func playerImageViewDidTap(_ sender: UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .savedPhotosAlbum
        picker.delegate = self
        present(picker, animated: true)
    }
    
    private func setPlayerImageViewConstaraints() {
        playerImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(playerImageView)
    }
    
    // MARK: Segmented Controls
    private func setupSegmentedControlsStackView() {
        segmentedControlsStackView.axis = .vertical
        segmentedControlsStackView.alignment = .center
        segmentedControlsStackView.distribution = .fillEqually
        segmentedControlsStackView.spacing = Constants.spacing20
        segmentedControlsStackView.backgroundColor = .systemYellow
        segmentedControlsStackView.isLayoutMarginsRelativeArrangement = true
        setupSegmentedControlsStackViewConstraints()
    }
    
    private func setupSegmentedControlsStackViewConstraints() {
        segmentedControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(segmentedControlsStackView)
        
        NSLayoutConstraint.activate([
            segmentedControlsStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor,
                                                   constant: Constants.constraint20),
            segmentedControlsStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,
                                                    constant: Constants.constraintMinus20),
            segmentedControlsStackView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor,
                                                    constant: Constants.constraintMinus20)
        ])
    }
    
    private func setupCarSegmentedControl() {
        carSegmentedControl.backgroundColor = .systemYellow
        carSegmentedControl.selectedSegmentTintColor = .yellow
        carSegmentedControl.selectedSegmentIndex = LocalConstants.selectedCarSegment
        carSegmentedControl.addTarget(self, action: #selector(carSegmentedControlDidChange),
                                      for: .valueChanged)
        setupCarSegmentedControlConstraints()
    }
    
    private func setupCarSegmentedControlConstraints() {
        carSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControlsStackView.addArrangedSubview(carSegmentedControl)
        
        NSLayoutConstraint.activate([
            carSegmentedControl.leadingAnchor.constraint(equalTo: stackView.leadingAnchor,
                                                   constant: Constants.constraint20),
            carSegmentedControl.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,
                                                    constant: Constants.constraintMinus20)
        ])
    }
    
    @objc private func carSegmentedControlDidChange(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            segmentedControl.selectedSegmentTintColor = .systemRed
        case 2:
            segmentedControl.selectedSegmentTintColor = .systemGreen
        default:
            segmentedControl.selectedSegmentTintColor = .yellow
        }
    }
    
    private func saveSelectedCar() {
        switch carSegmentedControl.selectedSegmentIndex {
        case 0:
            GameState.player.car = .red
        case 2:
            GameState.player.car = .green
        default:
            GameState.player.car = .yellow
        }
    }
    
    private func setupObstaclesSegmentedControl() {
        obstaclesSegmentedControl.backgroundColor = .systemYellow
        obstaclesSegmentedControl.selectedSegmentTintColor = UIColor(white: LocalConstants.selectedSegmentWhite,
                                                                     alpha: LocalConstants.selectedSegmentAlfa)
        obstaclesSegmentedControl.selectedSegmentIndex = LocalConstants.selectedCarSegment
        obstaclesSegmentedControl.addTarget(self, action: #selector(obstaclesSegmentedControlDidChange),
                                      for: .valueChanged)
        setupObstaclesSegmentedControlConstraints()
    }
    
    private func setupObstaclesSegmentedControlConstraints() {
        obstaclesSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControlsStackView.addArrangedSubview(obstaclesSegmentedControl)
        
        NSLayoutConstraint.activate([
            obstaclesSegmentedControl.leadingAnchor.constraint(equalTo: stackView.leadingAnchor,
                                                   constant: Constants.constraint20),
            obstaclesSegmentedControl.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,
                                                    constant: Constants.constraintMinus20)
        ])
    }
    
    //TODO: Chenge car when Save button pressed
    @objc private func obstaclesSegmentedControlDidChange(_ segmentedControl: UISegmentedControl) {
        print(#function)
    }
    
    private func saveSelectedObstacle() {
        switch obstaclesSegmentedControl.selectedSegmentIndex {
        case 0:
            GameState.player.obstacle = .picup
        case 2:
            GameState.player.obstacle = .bus
        default:
            GameState.player.obstacle = .police
        }
    }
    
    private func setupSpeedSegmentedControl() {
        speedSegmentedControl.backgroundColor = .systemYellow
        speedSegmentedControl.selectedSegmentTintColor = UIColor(white: LocalConstants.selectedSegmentWhite,
                                                                     alpha: LocalConstants.selectedSegmentAlfa)
        speedSegmentedControl.selectedSegmentIndex = LocalConstants.selectedCarSegment
        speedSegmentedControl.addTarget(self, action: #selector(speedSegmentedControlDidChange),
                                      for: .valueChanged)
        setupSpeedSegmentedControlConstraints()
    }
    
    private func setupSpeedSegmentedControlConstraints() {
        obstaclesSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControlsStackView.addArrangedSubview(speedSegmentedControl)
        
        NSLayoutConstraint.activate([
            speedSegmentedControl.leadingAnchor.constraint(equalTo: stackView.leadingAnchor,
                                                   constant: Constants.constraint20),
            speedSegmentedControl.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,
                                                    constant: Constants.constraintMinus20)
        ])
    }
    
    //TODO: Chenge car when Save button pressed
    @objc private func speedSegmentedControlDidChange(_ segmentedControl: UISegmentedControl) {
        print(#function)
    }
    
    private func saveSelectedSpeed() {
        switch speedSegmentedControl.selectedSegmentIndex {
        case 0:
            GameState.player.speed = .slow
        case 2:
            GameState.player.speed = .fast
        default:
            GameState.player.speed = .normal
        }
    }
    
    //MARK: Save button
    private func setupSaveButton() {
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.addTarget(self, action: #selector(saveButtonDidPress), for: .touchUpInside)
        segmentedControlsStackView.addArrangedSubview(saveButton)
    }
    
    @objc private func saveButtonDidPress() {
        saveSelectedCar()
        saveSelectedObstacle()
        saveSelectedSpeed()
        savePlayerName()
        savePlayerImage()
        GameState.saveState()
    }
    
    private func savePlayerName() {
        if let text = nameTextField.text {
            GameState.player.name = text
        }
    }
    
    private func savePlayerImage() {
        GameState.player.image = playerImageView.image
    }
}

//MARK:  UIImagePickerController
extension SettingsViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImage: UIImage
        
        if let possibleImage = info[.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[.originalImage] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        
        stackView.distribution = .equalCentering
        playerImageView.image = newImage
        dismiss(animated: true)
    }
}
