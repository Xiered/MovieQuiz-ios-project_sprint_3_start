//
//  QuestionFactory.swift
//  MovieQuiz
//
//  Created by Дмитрий Герасимов on 21.08.2023.
//

import Foundation

public enum CustomError: Error {
    case emptyItems(errorMessage: String)
    case imageLoadError
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .emptyItems(let errorMessage):
            return NSLocalizedString(errorMessage, comment: "Client Error")
        case .imageLoadError:
            return NSLocalizedString("Image load error", comment: "Image load error")
        }
    }
}


class QuestionFactory: QuestionFactoryProtocol {
    
   
   
    
    private let moviesLoader: MoviesLoading
    private weak var delegate: QuestionFactoryDelegate?
    private var movies: [MostPopularMovie] = []
    
    init(moviesLoader: MoviesLoading, delegate: QuestionFactoryDelegate?) {
        self.moviesLoader = moviesLoader
        self.delegate = delegate
    }
    
    func loadData() {
        moviesLoader.loadMovies { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else {return}
                switch result {
                case .success(let mostPopularMovies):
                    self.movies = mostPopularMovies.items
                    self.delegate?.didLoadDataFromServer()
                case .failure(let error):
                    self.delegate?.didFailToLoadData(with: error)
                }
            }
        }
    }
        
        
        func requestNextQuestion() {
            DispatchQueue.global().async { [weak self] in
                guard let self = self else { return }
                let index = (0..<self.movies.count).randomElement() ?? 0
                
                guard let movie = self.movies[safe: index] else { return }
                
                var imageData = Data()
                
                do {
                    imageData = try Data(contentsOf: movie.resizedImageUrl)
                } catch {
                    print("Failed to load image")
                    let error: Error = CustomError.imageLoadError
                    self.delegate?.didFailToLoadData(with: error)
                    return
                }
                let randomRating = Array(4...9).randomElement() ?? 5
                let rating = Float(movie.rating) ?? 0
                var text = ""
                var correctAnswer = false
                if randomRating % 2 == 0 {
                    text = "Рейтинг этого фильма больше чем \(randomRating)"
                    correctAnswer = rating > Float(randomRating)
                }
                else {
                    text = "Рейтинг это фильма меньше чем \(randomRating)"
                    correctAnswer = rating < Float(randomRating)
                }
                
                let question = QuizQuestion(image: imageData, text: text, correctAnswer: correctAnswer)
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.delegate?.didReceiveNextQuestion(question: question)
                }
            }
            
        }
    }
