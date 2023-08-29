//
//  StatisticServiceProtocol.swift
//  MovieQuiz
//
//  Created by Дмитрий Герасимов on 29.08.2023.
//

import Foundation

protocol StatisticService {
    func store(correct count: Int, totam amount: Int)
    var totalAccyracy: Double { get }
    var gamesCount: Int { get }
    var bestGame: GameRecord { get }
}
