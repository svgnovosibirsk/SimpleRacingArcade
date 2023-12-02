//
//  GameState.swift
//  SimpleRacingArcade
//
//  Created by Sergey on 29.11.2023.
//

import Foundation

//struct GameStateDTO {
//    let player: Player
//    let records: [Int] // Player?
//}

final class GameState {
    //MARK: - Properties
    //TODO: make storage via protocol and dependency injection
    private static let storage = UserDefaultsStorage.shared
    static var player = Player(name: "Unknown", car: .red, speed: .normal, obstacle: .picup)
    static var records: [Record] = []
    
    //TODO: Singleton?
//    static var shared: GameState = {
//        let instance = GameState()
//        return instance
//    }()
//
//    //MARK: - Lifecycle
//    private init() {}
    
    //MARK: - Flow
//    static func saveState() {
//        let dto = GameStateDTO(player: player, records: records)
//        storage.saveGameState(dto: dto)
//    }
//
//    static func fetchState() {
//        if let dto = storage.fetchGameState() {
//            player = dto.player
//            records = dto.records
//        }
//    }
    
    static func saveState() {
        storage.saveGameState()
    }
    
    static func fetchState() {
        storage.fetchGameState()
    }
    
    static func updateRecords() {
        if records.count < 5 {
            let record = Record(name: GameState.player.name, score: GameState.player.score)
            records.append(record)
        } else {
            records = records.sorted{ $0.score > $1.score }
            if let minRecord = records.last?.score {
                if GameState.player.score > minRecord {
                    let record = Record(name: GameState.player.name, score: GameState.player.score)
                    records[records.count - 1] = record
                }
            }
        }
    }
}
