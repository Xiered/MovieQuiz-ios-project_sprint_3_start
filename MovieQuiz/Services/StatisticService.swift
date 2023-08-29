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
    
    var totalAccuracy: Double = 0.0
    
    var gamesCount: Int = 0
    
    var bestGame: GameRecord {
        get {
        
        }
        set {
            
        }
    }
    
    // MARK: - Methods
    
    func store(correct count: Int, total amount: Int) {
        <#code#>
    }
    
    
}
