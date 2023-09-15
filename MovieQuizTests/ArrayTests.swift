//
//  ArrayTests.swift
//  MovieQuizTests
//
//  Created by Дмитрий Герасимов on 15.09.2023.
//

import Foundation
import XCTest
@testable import MovieQuiz

class ArrayTest: XCTestCase {
    
    func testGetValueInRagne() throws {
        
        // Given
        let array = [1, 2, 3,4, 5]
        
        // When
        
        let value = array[safe: 2]
        
        // Then
        
        XCTAssertNotNil(value)
        XCTAssertEqual(value, 2)
    }
    
    func testGetValueOutOfRange() throws {
        // Given
        let array = [1, 1, 2, 3, 5]
        
        // When
        let value = array[safe: 20]
        
        // Then
        XCTAssertNil(value)
    }
    
}
