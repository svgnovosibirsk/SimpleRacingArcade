//
//  GameState.swift
//  SimpleRacingArcade
//
//  Created by Sergey on 29.11.2023.
//

import Foundation

final class GameState {
    //MARK: - Properties
    let storage = UserDefaultsStorage.shared
    var player = Player(name: "Unknown", car: .red, speed: .slow, obstacle: .picup)
    var records: [Int] = []
    
    static var shared: GameState = {
        let instance = GameState()
        return instance
    }()
    
    //MARK: - Lifecycle
    private init() {}
}
