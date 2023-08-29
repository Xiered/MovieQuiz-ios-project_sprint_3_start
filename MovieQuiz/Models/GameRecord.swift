//
//  GameRecord.swift
//  MovieQuiz
//
//  Created by Дмитрий Герасимов on 29.08.2023.
//

import Foundation

struct GameRecord: Codable {
    let correct: Int
    let total: Int
    let date: Date
    
    func < (currentResult: GameRecord, bestResult: GameRecord) -> Bool {
        return currentResult.correct < bestResult.correct
    }
}
