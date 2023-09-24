//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Дмитрий Герасимов on 23.08.2023.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didRecieveNextQuestion(question: QuizQuestion?)
    
    func didLoadDataFromServer()
    
    func didFailToLoadData(with error: Error)
    
    func didFailToLoadImage(with error: Error)
    
    
}
