//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Дмитрий Герасимов on 23.08.2023.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
}
