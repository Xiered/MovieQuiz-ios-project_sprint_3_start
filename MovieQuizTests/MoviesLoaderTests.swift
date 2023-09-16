//
//  MoviesLoaderTests.swift
//  MovieQuizTests
//
//  Created by Дмитрий Герасимов on 16.09.2023.
//

import Foundation
import XCTest
@testable import MovieQuiz


class MovieLoaderTests: XCTestCase {
    
    func testSuccessLoading() {
        // Given
        
        let loader = MoviesLoader()
        
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
        // When
        // Then
    }
}
