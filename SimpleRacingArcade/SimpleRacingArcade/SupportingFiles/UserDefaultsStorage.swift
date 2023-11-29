//
//  UserDefaultsStorage.swift
//  SimpleRacingArcade
//
//  Created by Sergey on 29.11.2023.
//

import Foundation

protocol StorageProtocol {
    func saveGameState()
    func fetchGameState()
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
    func saveGameState() {
        print(#function)
    }
    
    func fetchGameState() {
        print(#function)
    }
}
