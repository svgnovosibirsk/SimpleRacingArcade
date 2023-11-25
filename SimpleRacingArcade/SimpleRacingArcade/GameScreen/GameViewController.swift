//
//  GameViewController.swift
//  SimpleRacingArcade
//
//  Created by Sergey on 21.11.2023.
//

import UIKit

final class GameViewController: UIViewController {
    
    //MARK: - Constants
    private enum LocalConstants {
        static let left = "L"
        static let right = "R"
    }
    
    //MARK: - Properties
    var obstacalesTimer: Timer?
    var collisionTimer: Timer?
    //TODO: put collision and score methods in one timer
    var scoreTimer: Timer?
    var isScoreOneMonitoring = true
    var isScoreTwoMonitoring = true
    
    var score = 0 {
        didSet {
            title = "Score: \(score)"
        }
    }
    
    var isGameOver = false {
        didSet {
            gameOver()
        }
    }
    
    //MARK: - Views
    //TODO: position all views via constraints NOT frames
    //TODO: put center strips in one superview
    let centerStrip: UIView  = {
        let strip = UIView()
        strip.frame = CGRect(origin: .zero, size: CGSize(width: 10, height: 100))
        strip.backgroundColor = .white
        strip.translatesAutoresizingMaskIntoConstraints = false
        return strip
    }()
    
    let centerStrip2: UIView  = {
        let strip = UIView()
        strip.frame = CGRect(origin: .zero, size: CGSize(width: 10, height: 100))
        strip.backgroundColor = .white
        strip.translatesAutoresizingMaskIntoConstraints = false
        return strip
    }()
    
    let centerStrip3: UIView  = {
        let strip = UIView()
        strip.frame = CGRect(origin: .zero, size: CGSize(width: 10, height: 100))
        strip.backgroundColor = .white
        strip.translatesAutoresizingMaskIntoConstraints = false
        return strip
    }()
    
    let leftRoadSide: UIView  = {
        let roadSide = UIView()
        roadSide.frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 1000))
        roadSide.backgroundColor = .systemYellow
        roadSide.translatesAutoresizingMaskIntoConstraints = false
        return roadSide
    }()
    
    let rightRoadSide: UIView  = {
        let roadSide = UIView()
        roadSide.frame = CGRect(origin: CGPoint(x: 300, y: 0), size: CGSize(width: 100, height: 1000))
        roadSide.backgroundColor = .systemYellow
        roadSide.translatesAutoresizingMaskIntoConstraints = false
        return roadSide
    }()
    
    let leftCactus: UIView  = {
        let cactus = UIView()
        cactus.frame = CGRect(origin: .zero, size: CGSize(width: 50, height: 90))
        cactus.backgroundColor = .systemGreen
        cactus.translatesAutoresizingMaskIntoConstraints = false
        return cactus
    }()
    
    let leftCactus2: UIView  = {
        let cactus = UIView()
        cactus.frame = CGRect(origin: .zero, size: CGSize(width: 50, height: 90))
        cactus.backgroundColor = .systemGreen
        cactus.translatesAutoresizingMaskIntoConstraints = false
        return cactus
    }()
    
    let rightCactus: UIView  = {
        let cactus = UIView()
        cactus.frame = CGRect(origin: .zero, size: CGSize(width: 50, height: 90))
        cactus.backgroundColor = .systemGreen
        cactus.translatesAutoresizingMaskIntoConstraints = false
        return cactus
    }()
    
    let obstacle: UIView  = {
        let obstacle = UIView()
        obstacle.frame = CGRect(origin: .zero, size: CGSize(width: 50, height: 50))
        obstacle.backgroundColor = .systemBlue
        obstacle.translatesAutoresizingMaskIntoConstraints = false
        return obstacle
    }()
    
    let obstacle2: UIView  = {
        let obstacle = UIView()
        obstacle.frame = CGRect(origin: .zero, size: CGSize(width: 50, height: 50))
        obstacle.backgroundColor = .systemBlue
        obstacle.translatesAutoresizingMaskIntoConstraints = false
        return obstacle
    }()
    
    let racingCar: UIView  = {
        let car = UIView()
        car.frame = CGRect(origin: .zero, size: CGSize(width: 60, height: 80))
        car.backgroundColor = .systemRed
        car.translatesAutoresizingMaskIntoConstraints = false
        return car
    }()
    
    // TODO: custom view to buttons
    let leftButton: UIButton  = {
        let button = UIButton()
        button.frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
        button.setTitle(LocalConstants.left, for: .normal)
        button.setTitleColor(.systemGray2, for: .highlighted)
        button.backgroundColor = UIColor(white: 0, alpha: 0.4)
        button.layer.cornerRadius = button.frame.width / 2
        //button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let rightButton: UIButton  = {
        let button = UIButton()
        button.frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
        button.setTitle(LocalConstants.right, for: .normal)
        button.setTitleColor(.systemGray2, for: .highlighted)
        button.backgroundColor = UIColor(white: 0, alpha: 0.4)
        button.layer.cornerRadius = button.frame.width / 2
        //button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Score: \(score)"
        view.backgroundColor = .systemGray3
        setupRoadScreen()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        enableButtons()
        
        UIView.animate(withDuration: 3, delay: 0, options: [.curveLinear, .repeat]) {
            self.centerStrip.frame.origin = CGPoint(x: self.view.center.x, y: 200)
            self.centerStrip2.frame.origin = CGPoint(x: self.view.center.x, y: 500)
            self.centerStrip3.frame.origin = CGPoint(x: self.view.center.x, y: 800)
            
            self.leftCactus.frame.origin = CGPoint(x: 20, y: 450)
            self.leftCactus2.frame.origin = CGPoint(x: 20, y: 850)
        }
        
        UIView.animate(withDuration: 6, delay: 0, options: [.curveLinear, .repeat]) {
            self.rightCactus.frame.origin = CGPoint(x: 320, y: 850)
        }
        
        setupObstaclesTimer()
        setupCollisionTimer()
        setupScoreTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        obstacalesTimer?.invalidate()
        collisionTimer?.invalidate()
    }
    
    //MARK: - Flow
    private func setupRoadScreen() {
        setupCenterStrip()
        setupRoadSides()
        setupCactuses()
        setupObstacle()
        setupRacingCar()
        setupButtons()
    }
    
    private func setupCenterStrip() {
        view.addSubview(centerStrip)
        centerStrip.frame.origin = CGPoint(x: view.center.x, y: -100)
        
        view.addSubview(centerStrip2)
        centerStrip2.frame.origin = CGPoint(x: view.center.x, y: 200)
        
        view.addSubview(centerStrip3)
        centerStrip3.frame.origin = CGPoint(x: view.center.x, y: 500)
    }
    
    private func setupRoadSides() {
        view.addSubview(leftRoadSide)
        view.addSubview(rightRoadSide)
    }
    
    private func setupCactuses() {
        view.addSubview(leftCactus)
        leftCactus.frame.origin = CGPoint(x: 20, y: -50)
        
        view.addSubview(leftCactus2)
        leftCactus2.frame.origin = CGPoint(x: 20, y: 450)
        
        view.addSubview(rightCactus)
        rightCactus.frame.origin = CGPoint(x: 320, y: -150)
    }
    
    private func setupObstacle() {
        view.addSubview(obstacle)
        obstacle.frame.origin = CGPoint(x: 150, y: -50)
        
        view.addSubview(obstacle2)
        obstacle2.frame.origin = CGPoint(x: 250, y: -350)
    }
    
    private func setupRacingCar() {
        view.addSubview(racingCar)
        racingCar.frame.origin = CGPoint(x: view.center.x - 50, y: 600)
    }
    
    private func setupButtons() {
        view.addSubview(leftButton)
        leftButton.frame.origin = CGPoint(x: 50, y: 700)
        leftButton.addTarget(self, action: #selector(leftButtonDidPress), for: .touchDown)
        
        view.addSubview(rightButton)
        rightButton.frame.origin = CGPoint(x: 250, y: 700)
        rightButton.addTarget(self, action: #selector(rightButtonDidPress), for: .touchDown)
    }
    
    // TODO: limit car position by screen frame
    // TODO: make continious move when button is pressed
    @objc func leftButtonDidPress() {
        var carPositionX = racingCar.frame.origin.x
        carPositionX -= 10
        UIView.animate(withDuration: 0.3) {
            self.racingCar.frame.origin.x = carPositionX
        }
    }
    
    @objc func rightButtonDidPress() {
        var carPositionX = racingCar.frame.origin.x
        carPositionX += 10
        UIView.animate(withDuration: 0.3) {
            self.racingCar.frame.origin.x = carPositionX
        }
    }
    
    private func setupObstaclesTimer() {
        obstacalesTimer = Timer.scheduledTimer(timeInterval: 12,
                                         target: self,
                                         selector: #selector(generateObstacles),
                                         userInfo: nil,
                                         repeats: true)
    }
    
    @objc func generateObstacles() {
        let randomX1 = Int.random(in: 20...250)
        obstacle.frame.origin = CGPoint(x: randomX1, y: -50)
        
        let randomX2 = Int.random(in: 20...250)
        obstacle2.frame.origin = CGPoint(x: randomX2, y: -350)
        
        UIView.animate(withDuration: 12, delay: 0, options: [.curveLinear]) {
            self.obstacle.frame.origin = CGPoint(x: randomX1, y: 1150)
            self.obstacle2.frame.origin = CGPoint(x: randomX2, y: 850)
        } completion: { isDone in
            self.isScoreOneMonitoring = true
            self.isScoreTwoMonitoring = true
        }
    }
    
    private func setupCollisionTimer() {
        collisionTimer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(monitorObstaclesCollisions),
                                         userInfo: nil,
                                         repeats: true)
    }
    
    @objc func monitorObstaclesCollisions() {
        if isViewIntersecting(racingCar) {
            isGameOver = true
        }
        
        //TODO: put all obstacles in array and iterate over array
  
        let obstacleFrame = obstacle.layer.presentation()?.frame
        if (CGRectIntersectsRect(obstacleFrame!, racingCar.frame)) {
            isGameOver = true
        }
        
        let obstacleFrame2 = obstacle2.layer.presentation()?.frame
        if (CGRectIntersectsRect(obstacleFrame2!, racingCar.frame)) {
            isGameOver = true
        }
    }
    
    //TODO: put collision and score methods in one timer
    private func setupScoreTimer() {
        scoreTimer = Timer.scheduledTimer(timeInterval: 0.5,
                                         target: self,
                                         selector: #selector(monitorObstaclesAvoiding),
                                         userInfo: nil,
                                         repeats: true)
    }
    
    @objc func monitorObstaclesAvoiding() {
        let obstacleFrame = obstacle.layer.presentation()?.frame
        let obstacleFrame2 = obstacle2.layer.presentation()?.frame
        
        if isScoreOneMonitoring && (obstacleFrame?.origin.y)! > racingCar.frame.origin.y + racingCar.frame.height{
            score += 1
            isScoreOneMonitoring = false
        }
        
        if isScoreTwoMonitoring && (obstacleFrame2?.origin.y)! > racingCar.frame.origin.y + racingCar.frame.height {
            score += 1
            isScoreTwoMonitoring = false
        }
    }
    
    private func isViewIntersecting(_ viewToCheck: UIView) -> Bool {
        let allSubViews = self.view!.subviews
        for theView in allSubViews {
            if (!(viewToCheck .isEqual(theView))) {
                if (CGRectIntersectsRect(viewToCheck.frame, theView.frame)) {
                    return true
                }
            }
        }
        return false
    }
    
    // TODO: put unconnected methods in extensions Ex: GameViewController+GameOver
    private func gameOver() {
        isScoreOneMonitoring = false
        isScoreTwoMonitoring = false
        disableButtons()
        showGameOverAlert()
    }
    
    private func resumeGame() {
        score = 0
        isScoreOneMonitoring = true
        isScoreTwoMonitoring = true
        enableButtons()
        resetCarAndObstaclesPositions()
    }
    
    private func resetCarAndObstaclesPositions() {
        racingCar.frame.origin = CGPoint(x: view.center.x - 50, y: 600)
        obstacle.frame.origin = CGPoint(x: 150, y: -50)
        obstacle2.frame.origin = CGPoint(x: 250, y: -350)
    }
    
    private func disableButtons() {
        leftButton.isEnabled = false
        leftButton.alpha = 0.1
        rightButton.isEnabled = false
        rightButton.alpha = 0.1
    }
    
    private func enableButtons() {
        leftButton.isEnabled = true
        leftButton.alpha = 1
        rightButton.isEnabled = true
        rightButton.alpha = 1
    }
    
    private func showGameOverAlert() {
        let alert = UIAlertController(title: "GAME OVER", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Resume", style: .default) { [weak self] action in
            guard let self = self else { return }
            self.resumeGame()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}
