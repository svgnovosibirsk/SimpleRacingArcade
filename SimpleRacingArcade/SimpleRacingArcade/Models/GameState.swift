//
//  GameState.swift
//  SimpleRacingArcade
//
//  Created by Sergey on 29.11.2023.
//

import Foundation

final class GameState {
    //MARK: - Properties
    private static let storage = UserDefaultsStorage.shared
    static var player = Player(name: "Unknown", car: .red, speed: .normal, obstacle: .picup)
    static var records: [Record] = []
    
    //MARK: - Methods
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
