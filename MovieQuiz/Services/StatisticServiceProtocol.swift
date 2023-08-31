//
//  StatisticServiceProtocol.swift
//  MovieQuiz
//
//  Created by Дмитрий Герасимов on 29.08.2023.
//

import Foundation

protocol StatisticService {
    func store(correct count: Int, total amount: Int)
    var totalAccuracy: Double { get }
    var gamesCount: Int { get }
    var bestGame: GameRecord { get }
}
