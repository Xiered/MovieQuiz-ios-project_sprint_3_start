//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Дмитрий Герасимов on 29.08.2023.
//

import Foundation

final class StatisticServiceTempImplementation: StatisticService {
    
    // MARK: - Variables
    
    private let userDefaults = UserDefaults.standard
    
    private enum Keys: String {
        case correct, total, bestGame, gamesCount
    }
    
    var totalAccuracy: Double = 0.0
    
    var gamesCount: Int = 0
    
    var bestGame: GameRecord {
        get {
        
        }
        set {
            guard let data = JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }
            userDefaults.set(data, forKey: Keys.bestGame.rawValue)
        }
    }
    
    // MARK: - Methods
    
    func store(correct count: Int, total amount: Int) {
        <#code#>
    }
    
    
}
