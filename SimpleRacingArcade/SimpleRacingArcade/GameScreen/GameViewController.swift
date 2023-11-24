//
//  GameViewController.swift
//  SimpleRacingArcade
//
//  Created by Sergey on 21.11.2023.
//

import UIKit

final class GameViewController: UIViewController {

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
    
    let racingCar: UIView  = {
        let car = UIView()
        car.frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 150))
        car.backgroundColor = .systemRed
        car.translatesAutoresizingMaskIntoConstraints = false
        return car
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.gameScreenTitle
        view.backgroundColor = .systemGray3
       setupRoadScreen()
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
    }
    
    private func setupRoadScreen() {
        setupCenterStrip()
        setupRoadSides()
        setupCactuses()
        setupRacingCar()
        
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
    
    private func setupRacingCar() {
        view.addSubview(racingCar)
        racingCar.frame.origin = CGPoint(x: view.center.x - 50, y: 700)
    }
}
