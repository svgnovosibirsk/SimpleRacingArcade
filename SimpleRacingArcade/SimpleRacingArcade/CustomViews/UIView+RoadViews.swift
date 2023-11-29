//
//  UIView+RoadViews.swift
//  SimpleRacingArcade
//
//  Created by Sergey on 29.11.2023.
//

import UIKit

//MARK: - Constants
private enum LocalConstants {
    static let cactusImage = "cactus"
}

extension UIView {
    class func centralStrip() -> UIView {
        let strip = UIView()
        strip.frame = CGRect(origin: .zero, size: CGSize(width: Constants.constraint10,
                                                         height: Constants.constraint100))
        strip.backgroundColor = .white
        strip.translatesAutoresizingMaskIntoConstraints = false
        return strip
    }
    
    class func roadSide() -> UIView {
        let roadSide = UIView()
        roadSide.backgroundColor = .systemYellow
        roadSide.translatesAutoresizingMaskIntoConstraints = false
        return roadSide
    }
    
    class func roadCuctus() -> UIView {
        let cactus = UIView()
        cactus.backgroundColor = .clear
        cactus.translatesAutoresizingMaskIntoConstraints = false
        let cactusImage = UIImage(named: LocalConstants.cactusImage)
        let cactusImageView = UIImageView(image: cactusImage)
        cactus.addSubview(cactusImageView)
        return cactus
    }
    
    class func roadObstacle(withName name: String) -> UIView {
        let obstacle = UIView()
        obstacle.frame = CGRect(origin: .zero, size: CGSize(width: Constants.constraint50,
                                                            height: Constants.constraint60))
        obstacle.backgroundColor = .clear
        obstacle.translatesAutoresizingMaskIntoConstraints = false
        let obstacleImage = UIImage(named: name)
        let obstacleImageView = UIImageView(image: obstacleImage)
        obstacle.addSubview(obstacleImageView)
        obstacleImageView.center = obstacle.center
        return obstacle
    }
    
    class func racingCar(withName name: String) -> UIView {
        let car = UIView()
        car.frame = CGRect(origin: .zero, size: CGSize(width: Constants.constraint50,
                                                       height: Constants.constraint60))
        car.backgroundColor = .clear
        car.translatesAutoresizingMaskIntoConstraints = false
        let carImage = UIImage(named: name)
        let carImageView = UIImageView(image: carImage)
        car.addSubview(carImageView)
        carImageView.center = car.center
        return car
    }
}


