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
        static let score = "Score:"
        static let policeCar = "policeCar"
        static let picup = "picup"
        static let bus = "bus"
        static let redCar = "redCar"
        static let greenCar = "greenCar"
        static let yellowCar = "yellowCar"
        static let gameOver = "GAME OVER"
        static let resume = "Resume"
        static let prizeScore = 1
        static let alpha01: CGFloat = 0.1
        static let alpha1: CGFloat = 1
        static let stripInset5: CGFloat = 5
        static let speedFast: CGFloat = 4
        static let speedNormal: CGFloat = 8
        static let speedSlow: CGFloat = 12
    }
    
    //MARK: - Properties
    var obstacalesTimer: Timer?
    var collisionTimer: Timer?
    var isScoreOneMonitoring = true
    var isScoreTwoMonitoring = true
    var isCollisionDetecting = true
    var screenWidth: CGFloat = 0
    var screenHeight: CGFloat = 0
    
    var score = 0 {
        didSet {
            title = "\(LocalConstants.score) \(score)"
            GameState.player.score = score
        }
    }
    
    var isGameOver = false {
        didSet {
            gameOver()
        }
    }
    
    var player: Player?
    
    //MARK: - Views
    let centerStrip = UIView .centralStrip()
    let centerStrip2 = UIView .centralStrip()
    let centerStrip3 = UIView .centralStrip()
    
    let leftRoadSide = UIView.roadSide()
    let rightRoadSide = UIView.roadSide()
    
    let leftCactus = UIView.roadCuctus()
    let rightCactus = UIView.roadCuctus()

    var obstacle = UIView.roadObstacle(withName: LocalConstants.bus)
    var obstacle2 = UIView.roadObstacle(withName: LocalConstants.picup)
    var obstacleSpeed = Constants.timeInterval12
    
    var racingCar = UIView.racingCar(withName: LocalConstants.redCar)

    let leftButton = UIButton.controlButton(withTitle: LocalConstants.left)
    let rightButton = UIButton.controlButton(withTitle: LocalConstants.right)
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GameState.fetchState()
        
        title = "\(LocalConstants.score) \(score)"
        view.backgroundColor = .systemGray3
        
        GameState.fetchState()
        player = GameState.player
        
        screenWidth = view.bounds.width
        screenHeight = view.bounds.height
        setupRoadScreen()
    }
        
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: Constants.duration03) {
            self.leftButton.layer.cornerRadius = self.leftButton.frame.width / 2
            self.leftButton.layer.masksToBounds = true
            
            self.rightButton.layer.cornerRadius = self.rightButton.frame.width / 2
            self.rightButton.layer.masksToBounds = true
        }
  
        enableButtons()
        
        UIView.animate(withDuration: Constants.duration6,
                       delay: Constants.delay0,
                       options: [.curveLinear, .repeat]) {
            self.centerStrip.frame.origin = CGPoint(x: self.view.center.x - LocalConstants.stripInset5,
                                                    y: Constants.constraint200)
            self.centerStrip2.frame.origin = CGPoint(x: self.view.center.x - LocalConstants.stripInset5,
                                                     y: Constants.constraint500)
            self.centerStrip3.frame.origin = CGPoint(x: self.view.center.x - LocalConstants.stripInset5,
                                                     y: Constants.constraint800)
        }
        
        UIView.animate(withDuration: Constants.duration12,
                       delay: Constants.delay0,
                       options: [.curveLinear, .repeat]) {
            self.leftCactus.frame.origin.y = self.screenHeight + Constants.constraint50
            self.rightCactus.frame.origin.y = self.screenHeight + Constants.constraint50
        }
        
        setupObstaclesTimer()
        setupCollisionTimer()
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
        centerStrip.frame.origin = CGPoint(x: view.center.x - LocalConstants.stripInset5,
                                           y: Constants.constraintMinus100)
        
        view.addSubview(centerStrip2)
        centerStrip2.frame.origin = CGPoint(x: view.center.x -  LocalConstants.stripInset5,
                                            y: Constants.constraint200)
        
        view.addSubview(centerStrip3)
        centerStrip3.frame.origin = CGPoint(x: view.center.x -  LocalConstants.stripInset5,
                                            y: Constants.constraint500)
    }
    
    private func setupRoadSides() {
        view.addSubview(leftRoadSide)
        view.addSubview(rightRoadSide)
        
        NSLayoutConstraint.activate([
            leftRoadSide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leftRoadSide.widthAnchor.constraint(equalToConstant: Constants.constraint80),
            leftRoadSide.heightAnchor.constraint(equalToConstant: Constants.constraint1000),
            
            rightRoadSide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rightRoadSide.widthAnchor.constraint(equalToConstant: Constants.constraint80),
            rightRoadSide.heightAnchor.constraint(equalToConstant: Constants.constraint1000),
        ])
    }
    
    private func setupCactuses() {
        view.addSubview(leftCactus)
        leftCactus.frame.origin.y = Constants.constraintMinus50
        
        view.addSubview(rightCactus)
        rightCactus.frame.origin.y = Constants.constraintMinus50
        
        NSLayoutConstraint.activate([
            leftCactus.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.constraint20),
            leftCactus.widthAnchor.constraint(equalToConstant: Constants.constraint30),
            leftCactus.heightAnchor.constraint(equalToConstant: Constants.constraint80),
            
            rightCactus.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.constraintMinus20),
            rightCactus.widthAnchor.constraint(equalToConstant: Constants.constraint30),
            rightCactus.heightAnchor.constraint(equalToConstant: Constants.constraint80)
        ])
    }
    
    private func setupObstacle() {
        switch player?.obstacle {
        case.picup:
            obstacle = UIView.roadObstacle(withName: LocalConstants.picup)
            obstacle2 = UIView.roadObstacle(withName: LocalConstants.picup)
        case .bus:
            obstacle = UIView.roadObstacle(withName: LocalConstants.bus)
            obstacle2 = UIView.roadObstacle(withName: LocalConstants.bus)
        default:
            obstacle = UIView.roadObstacle(withName: LocalConstants.policeCar)
            obstacle2 = UIView.roadObstacle(withName: LocalConstants.policeCar)
        }
        
        view.addSubview(obstacle)
        obstacle.frame.origin = CGPoint(x: Constants.constraint150, y: Constants.constraintMinus100)
        
        view.addSubview(obstacle2)
        obstacle2.frame.origin = CGPoint(x: Constants.constraint250, y: Constants.constraintMinus350)
    }
    
    private func setupRacingCar() {
        switch player?.car {
        case .red:
            racingCar = UIView.racingCar(withName: LocalConstants.redCar)
        case .green:
            racingCar = UIView.racingCar(withName: LocalConstants.greenCar)
        default:
            racingCar = UIView.racingCar(withName: LocalConstants.yellowCar)
        }
        
        view.addSubview(racingCar)
        racingCar.frame.origin = CGPoint(x: view.center.x - racingCar.frame.width / 2,
                                         y: screenHeight - Constants.constraint200)
    }
    
    private func setupButtons() {
        view.addSubview(leftButton)
        leftButton.addTarget(self, action: #selector(leftButtonDidPress), for: .touchDown)
        
        view.addSubview(rightButton)
        rightButton.addTarget(self, action: #selector(rightButtonDidPress), for: .touchDown)
        
        NSLayoutConstraint.activate([
            leftButton.centerXAnchor.constraint(equalTo: view.centerXAnchor,
                                                constant: -leftButton.frame.width - Constants.constraint100),
            leftButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            leftButton.heightAnchor.constraint(equalToConstant: Constants.constraint100),
            leftButton.widthAnchor.constraint(equalToConstant: Constants.constraint100),
            
            rightButton.centerXAnchor.constraint(equalTo: view.centerXAnchor,
                                                 constant: +rightButton.frame.width + Constants.constraint100),
            rightButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            rightButton.heightAnchor.constraint(equalToConstant: Constants.constraint100),
            rightButton.widthAnchor.constraint(equalToConstant: Constants.constraint100),
        ])
    }
    
    @objc func leftButtonDidPress() {
        var carPositionX = racingCar.frame.origin.x
        carPositionX -= Constants.constraint10
        UIView.animate(withDuration: Constants.duration03) {
            self.racingCar.frame.origin.x = carPositionX
        }
    }
    
    @objc func rightButtonDidPress() {
        var carPositionX = racingCar.frame.origin.x
        carPositionX += Constants.constraint10
        UIView.animate(withDuration: Constants.duration03) {
            self.racingCar.frame.origin.x = carPositionX
        }
    }
    
    private func setObstacleSpeed() {
        switch player?.speed {
        case .fast:
            obstacleSpeed = LocalConstants.speedFast
        case .normal:
            obstacleSpeed = LocalConstants.speedNormal
        default:
            obstacleSpeed = LocalConstants.speedSlow
        }
    }
    
    private func setupObstaclesTimer() {
        setObstacleSpeed()
        
        obstacalesTimer = Timer.scheduledTimer(timeInterval: obstacleSpeed,
                                         target: self,
                                         selector: #selector(generateObstacles),
                                         userInfo: nil,
                                         repeats: true)
    }
    
    @objc func generateObstacles() {
        let leftLimit = Int(leftRoadSide.frame.origin.x + leftRoadSide.frame.width + Constants.constraint10)
        let rightLimit = Int(rightRoadSide.frame.origin.x - Constants.constraint50)
        
        let randomX1 = Int.random(in: leftLimit...rightLimit)
        obstacle.frame.origin = CGPoint(x: randomX1, y: Int(Constants.constraintMinus50))
        
        let randomX2 = Int.random(in: leftLimit...rightLimit)
        obstacle2.frame.origin = CGPoint(x: randomX2, y: Int(Constants.constraintMinus350))
        
        UIView.animate(withDuration: obstacleSpeed,
                       delay: Constants.delay0,
                       options: [.curveLinear]) {
            self.obstacle.frame.origin = CGPoint(x: randomX1, y: Int(Constants.constraint1150))
            self.obstacle2.frame.origin = CGPoint(x: randomX2, y: Int(Constants.constraint850))
        } completion: { isDone in
            self.isScoreOneMonitoring = true
            self.isScoreTwoMonitoring = true
        }
    }
    
    //MARK: Collisions
    private func setupCollisionTimer() {
        collisionTimer = Timer.scheduledTimer(timeInterval: Constants.timeInterval03,
                                              target: self,
                                              selector: #selector(monitorCollisionAndScore),
                                              userInfo: nil,
                                              repeats: true)
    }
    
    @objc func monitorCollisionAndScore() {
        monitorObstaclesCollisions()
        monitorObstaclesAvoiding()
    }
    
    func monitorObstaclesCollisions() {
        if isCollisionDetecting {
            let leftRoadSideFrame = leftRoadSide.frame
            if (CGRectIntersectsRect(leftRoadSideFrame, racingCar.frame)) {
                isGameOver = true
            }
            
            let rightRoadSideFrame = rightRoadSide.frame
            if (CGRectIntersectsRect(rightRoadSideFrame, racingCar.frame)) {
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
    }
    
    func monitorObstaclesAvoiding() {
        let obstacleFrame = obstacle.layer.presentation()?.frame
        let obstacleFrame2 = obstacle2.layer.presentation()?.frame
        
        if isScoreOneMonitoring && (obstacleFrame?.origin.y)! > racingCar.frame.origin.y + racingCar.frame.height{
            score += LocalConstants.prizeScore
            isScoreOneMonitoring = false
        }
        
        if isScoreTwoMonitoring && (obstacleFrame2?.origin.y)! > racingCar.frame.origin.y + racingCar.frame.height {
            score += LocalConstants.prizeScore
            isScoreTwoMonitoring = false
        }
    }
    
    // TODO: put unconnected methods in extensions Ex: GameViewController+GameOver
    private func gameOver() {
        isScoreOneMonitoring = false
        isScoreTwoMonitoring = false
        isCollisionDetecting = false
        disableButtons()
        showGameOverAlert()
        GameState.updateRecords()
        GameState.saveState()
    }
    
    private func resumeGame() {
        score = 0
        isScoreOneMonitoring = true
        isScoreTwoMonitoring = true
        isCollisionDetecting = true
        enableButtons()
        resetCarAndObstaclesPositions()
    }
    
    private func resetCarAndObstaclesPositions() {
        racingCar.frame.origin = CGPoint(x: view.center.x - racingCar.frame.width / 2,
                                         y: screenHeight - Constants.constraint200)
        obstacle.frame.origin = CGPoint(x: Int(Constants.constraint150),
                                        y: Int(Constants.constraintMinus50))
        obstacle2.frame.origin = CGPoint(x: Int(Constants.constraint250),
                                         y: Int(Constants.constraintMinus350))
    }
    
    private func disableButtons() {
        leftButton.isEnabled = false
        leftButton.alpha = LocalConstants.alpha01
        rightButton.isEnabled = false
        rightButton.alpha = LocalConstants.alpha01
    }
    
    private func enableButtons() {
        leftButton.isEnabled = true
        leftButton.alpha = LocalConstants.alpha1
        rightButton.isEnabled = true
        rightButton.alpha = LocalConstants.alpha1
    }
    
    private func showGameOverAlert() {
        let alert = UIAlertController(title: LocalConstants.gameOver, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: LocalConstants.resume, style: .default) { [weak self] action in
            guard let self = self else { return }
            self.resumeGame()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}
