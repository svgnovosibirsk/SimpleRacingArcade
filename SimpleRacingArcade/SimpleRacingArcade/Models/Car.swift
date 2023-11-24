//
//  Car.swift
//  SimpleRacingArcade
//
//  Created by Sergey on 21.11.2023.
//

import UIKit

enum Car: CaseIterable {
    case red
    case yellow
    case green
    
    static func cars() -> [String] {
        return ["Red", "Yellow", "Green"]
    }
}
