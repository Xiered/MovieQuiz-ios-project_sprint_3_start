//
//  MoviesLoaderTests.swift
//  MovieQuizTests
//
//  Created by Дмитрий Герасимов on 16.09.2023.
//

import Foundation
import XCTest
@testable import MovieQuiz

struct StubNetworkClient: NetworkRouting {
    
    enum TestError: Error { // Тестовая ошибка
        case test
    }
    
    let emulatedError: Bool
    
    func fetch(url: URL, handler: @escaping (Result<Data, Error>) -> Void) {
        if emulatedError {
            handler(.failure(TestError.test))
        } else {
            handler(.success(expectedResponse))
        }
    }
    
    private var expectedResponse: Data {
        """
        {
        "errorMessage" : "",
        "items" : [
            {
                "crew" : "Dan Trachtenberg (dir.), Amber Midthunder, Dakota Beavers",
                "fullTitle" : "Prey (2022)",
                "id" : "tt11866324",
                "imDbRating" : "7.2",
                "imDbRatingCount" : "93332",
                "image" : "https://m.media-amazon.com/images/M/MV5BMDBlMDYxMDktOTUxMS00MjcxLWE2YjQtNhMjNmN2Y3ZDA1XkEyXkFqcGdeQXVyMTM1MTE1NDMx._V1_Ratio0.6716_AL_.jpg",
                "rank" : "1",
                "rankUpDown" : "+23",
                "title" : "Prey",
                "year" : "2022"
            },
            {
                "crew" : "Anthony Russo (dir.), Ryan Gosling, Chris Evans",
                "fullTitle" : "The Gray Man (2022)",
                "id" : "tt1649418",
                "imDbRating" : "6.5",
                "imDbRatingCount" : "132890",
                "image" : "https://m.media-amazon.com/images/M/MV5BOWY4MmFiY2QtMzE1S00NTg1LWIwOtQtYTI4ZGUzNWIxNTVmXkEyXkFqcGdeQXVyODk4OTc3MTY@._V1_Ratio0.6716_AL_.jpg",
                "rank" : "2",
                "rankUpDown" : "-1",
                "title" : "The Gray Man",
                "year" : "2022"
                }
            ]
        }
        """.data(using: .utf8) ?? Data()
    }
}

class MovieLoaderTests: XCTestCase {
    
    func testSuccessLoading() {
        // Given
        let stubNetworkClient = StubNetworkClient(emulatedError: false)
        let loader = MoviesLoader(networkClient: stubNetworkClient)
        
        // When
        
        let expectation = expectation(description: "Loading expectation")
        loader.loadMovies { result in
            // Then
            switch result {
            case .success(let movies):
                expectation.fulfill()
            case .failure(_):
                XCTFail("Unexpected failure")
            }
        }
        waitForExpectations(timeout: 1)
    }

    
    func testFailureLoading() {
        // Given
        let stubNetworkClient = StubNetworkClient(emulatedError: true)
        let loader = MoviesLoader(networkClient: stubNetworkClient)
        
        // When
        let expectation = expectation(description: "Loading expectation")
        loader.loadMovies { result in
            // Then
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            case .success(_):
                XCTFail("Unexpected failure")
            }
        }
        waitForExpectations(timeout: 1)
    }
}
