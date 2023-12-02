//
//  Obstacle.swift
//  SimpleRacingArcade
//
//  Created by Sergey on 21.11.2023.
//

import Foundation

enum Obstacle: String {
    case picup
    case police
    case bus
    
    static func obstacles() -> [String] {
        return ["Picup", "Police", "Bus"]
    }
}
