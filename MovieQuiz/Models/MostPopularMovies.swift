//
//  MostPopularMovies.swift
//  MovieQuiz
//
//  Created by Дмитрий Герасимов on 02.09.2023.
//

import Foundation

struct MostPopularMovies {
    let errorMessage: String
    let items: [MostPopularMovie]
}

struct MostPopularMovie {
    let title: String
    let rating: String
    let imageURL: URL
}
