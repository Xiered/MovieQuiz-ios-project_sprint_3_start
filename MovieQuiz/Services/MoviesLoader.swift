//
//  MoviesLoader.swift
//  MovieQuiz
//
//  Created by Дмитрий Герасимов on 02.09.2023.
//

import Foundation

protocol MoviesLoading {
    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void)
}

struct MoviesLoader: MoviesLoading {
    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void) {
        
    }
}
