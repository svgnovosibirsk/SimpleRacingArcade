//
//  Player.swift
//  SimpleRacingArcade
//
//  Created by Sergey on 21.11.2023.
//

import UIKit

struct Player {
    let name: String
    var image: UIImage?
    var car: Car
    var speed: Int
    var obstacle: Obstacle
    var score = 0
}

#if DEBUG
extension Player {
    static var sampleData = [
        Player(name: "Max", car: Car.red, speed: 20, obstacle: Obstacle.block),
        Player(name: "Bob", car: Car.yellow, speed: 30, obstacle: Obstacle.car),
        Player(name: "Tim", car: Car.green, speed: 40, obstacle: Obstacle.water)
    ]
}
#endif
