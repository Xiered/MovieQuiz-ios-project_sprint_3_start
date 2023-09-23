//
//  MovieQuizPresenter.swift
//  MovieQuiz
//
//  Created by Дмитрий Герасимов on 23.09.2023.
//

import Foundation
import UIKit

final class MovieQuizPresenter {
    
     let questionsAmount: Int = 10
     var currentQuestionIndex: Int = 0
    
   
    
    func convert(model: QuizQuestion) -> QuizStepViewModel {
        return QuizStepViewModel(
            image: UIImage(data: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
    }
}
