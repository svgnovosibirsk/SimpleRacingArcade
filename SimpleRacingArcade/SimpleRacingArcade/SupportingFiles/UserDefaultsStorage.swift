//
//  UserDefaultsStorage.swift
//  SimpleRacingArcade
//
//  Created by Sergey on 29.11.2023.
//

import UIKit

protocol StorageProtocol {
//    func saveGameState(dto: GameStateDTO)
//    func fetchGameState() -> GameStateDTO?
    
    func saveGameState()
    func fetchGameState()
}

private enum LocalConstants {
    static let playerName = "playerName"
    static let playerScore = "playerScore"
    static let playerImage = "playerImage"
    static let playerCar = "playerCar"
    static let playerSpeed = "playerSpeed"
    static let playerObstacle = "playerObstacle"
    static let gameRecords = "gameRecords"
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
//    func saveGameState(dto: GameStateDTO) {
//        print(#function)
//    }
//
//    func fetchGameState() -> GameStateDTO? {
//        print(#function)
//        return nil
//    }
    
    func saveGameState() {
        let defaults = UserDefaults.standard
        defaults.set(GameState.player.name, forKey: LocalConstants.playerName)
        defaults.set(GameState.player.score, forKey: LocalConstants.playerScore)
        defaults.set(GameState.player.car.rawValue, forKey: LocalConstants.playerCar)
        defaults.set(GameState.player.speed.rawValue, forKey: LocalConstants.playerSpeed)
        defaults.set(GameState.player.obstacle.rawValue, forKey: LocalConstants.playerObstacle)
        savePlayerImage()
        defaults.set(GameState.records, forKey: LocalConstants.gameRecords)
    }
    
    func fetchGameState() {
        let defaults = UserDefaults.standard
        if let playerName = defaults.string(forKey: LocalConstants.playerName) {
            GameState.player.name = playerName
        }
        
        GameState.player.score = defaults.integer(forKey: LocalConstants.playerScore)
        
        if let playerCar = defaults.string(forKey: LocalConstants.playerCar) {
            if let car =  Car(rawValue: playerCar) {
                GameState.player.car = car
            }
        }
        
        if let playerSpeed = defaults.string(forKey: LocalConstants.playerSpeed) {
            if let speed =  Speed(rawValue: playerSpeed) {
                GameState.player.speed = speed
            }
        }
        
        if let playerObstacle = defaults.string(forKey: LocalConstants.playerObstacle) {
            if let obstacle =  Obstacle(rawValue: playerObstacle) {
                GameState.player.obstacle = obstacle
            }
        }
                
        loadImage()
        
        if let gameRecords = defaults.object(forKey: LocalConstants.playerImage) as? [Record] {
            GameState.records = gameRecords
        }
    }
}

private extension UserDefaultsStorage {
    func savePlayerImage() {
        guard let data = GameState.player.image?.jpegData(compressionQuality: 0.5) else { return }
        let encoded = try! PropertyListEncoder().encode(data)
        UserDefaults.standard.set(encoded, forKey: LocalConstants.playerImage)
    }
    
    func loadImage() {
        guard let data = UserDefaults.standard.data(forKey: LocalConstants.playerImage) else { return }
        let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
        let image = UIImage(data: decoded)
        GameState.player.image = image
    }
}
