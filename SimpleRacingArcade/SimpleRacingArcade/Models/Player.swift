//
//  Player.swift
//  SimpleRacingArcade
//
//  Created by Sergey on 21.11.2023.
//

import UIKit

struct Player {
    var name: String
    var image: UIImage?
    var car: Car
    var speed: Speed
    var obstacle: Obstacle
    var score = 0
}

#if DEBUG
extension Player {
    static var sampleData = [
        Player(name: "Max", car: .red, speed: .slow, obstacle: .bus, score: 10),
        Player(name: "Bob", car: .yellow, speed: .normal, obstacle: .picup, score: 20),
        Player(name: "Tim", car: .green, speed: .fast, obstacle: .police, score: 30)
    ]
}
#endif
