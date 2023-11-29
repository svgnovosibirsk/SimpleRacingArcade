//
//  Speed.swift
//  SimpleRacingArcade
//
//  Created by Sergey on 22.11.2023.
//

import Foundation

enum Speed {
    case slow
    case normal
    case fast
    
    static func speedOptions() -> [String] {
        return ["Slow", "Normal", "Fast"]
    }
}
