//
//  UserDefaultsStorage.swift
//  SimpleRacingArcade
//
//  Created by Sergey on 29.11.2023.
//

import Foundation

protocol StorageProtocol {
    func saveGameState(dto: GameStateDTO)
    func fetchGameState() -> GameStateDTO?
}

final class UserDefaultsStorage: StorageProtocol {
    //MARK: - Properties
    static var shared: UserDefaultsStorage = {
        let instance = UserDefaultsStorage()
        return instance
    }()
    
    //MARK: - Lifecycle
    private init() {}
    
    //MARK: - Flow
    func saveGameState(dto: GameStateDTO) {
        print(#function)
    }
    
    func fetchGameState() -> GameStateDTO? {
        print(#function)
        return nil
    }
}
