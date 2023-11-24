//
//  Obstacle.swift
//  SimpleRacingArcade
//
//  Created by Sergey on 21.11.2023.
//

import Foundation

enum Obstacle: CaseIterable {
    case car
    case block
    case water
    
    static func obstacles() -> [String] {
        return ["Car", "Block", "Water"]
    }
}
