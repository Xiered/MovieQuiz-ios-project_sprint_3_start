//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Дмитрий Герасимов on 29.08.2023.
//

import Foundation

final class StatisticServiceTempImplementation: StatisticService {
    
    // MARK: - Variables
    
    var correct: Int {
            userDefaults.integer(forKey: Keys.correct.rawValue)
    }
    
    var total: Int {
        userDefaults.integer(forKey: Keys.total.rawValue)
    }
    
    private let userDefaults = UserDefaults.standard
    
    private enum Keys: String {
        case correct, total, bestGame, gamesCount
    }
    
    var totalAccuracy: Double {
        get {
            let total = Double(userDefaults.integer(forKey: Keys.total.rawValue))
            let correct = Double(userDefaults.integer(forKey: Keys.correct.rawValue))
            return 100 * (correct / total)
        }
    }
    
    var gamesCount: Int {
        get {
            userDefaults.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var bestGame: GameRecord {
        get {
            guard let data = userDefaults.data(forKey: Keys.bestGame.rawValue),
                  let record = try? JSONDecoder().decode(GameRecord.self, from: data) else {
                return .init(correct: 0, total: 0, date: Date())
            }
            return record
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
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
