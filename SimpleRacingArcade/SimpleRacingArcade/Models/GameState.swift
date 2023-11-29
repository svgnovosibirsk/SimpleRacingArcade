//
//  GameState.swift
//  SimpleRacingArcade
//
//  Created by Sergey on 29.11.2023.
//

import Foundation

struct GameStateDTO {
    let player: Player
    let records: [Int] // Player?
}

final class GameState {
    //MARK: - Properties
    //TODO: make storage via protocol and dependency injection
    private static let storage = UserDefaultsStorage.shared
    static var player = Player(name: "Unknown", car: .red, speed: .normal, obstacle: .picup)
    static var records: [Int] = []
    
    //TODO: Singleton?
//    static var shared: GameState = {
//        let instance = GameState()
//        return instance
//    }()
//
//    //MARK: - Lifecycle
//    private init() {}
    
    //MARK: - Flow
    static func saveState() {
        let dto = GameStateDTO(player: player, records: records)
        storage.saveGameState(dto: dto)
    }
    
    static func fetchState() {
        if let dto = storage.fetchGameState() {
            player = dto.player
            records = dto.records
        }
    }
}
