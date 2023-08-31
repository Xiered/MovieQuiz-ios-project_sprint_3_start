//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Дмитрий Герасимов on 24.08.2023.
//

import Foundation
import UIKit

final class AlertPresenter: AlertPresenterProtocol {
    private weak var AlertViewController: UIViewController?
    
    init(AlertViewController: UIViewController? = nil) {
        self.AlertViewController = AlertViewController
    }
    
    func showAlert(quiz result: AlertModel) {
        let alert = UIAlertController(title: result.title, message: result.message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: result.buttonText, style: .default, handler: result.completion)
        alert.addAction(action)
        AlertViewController?.present(alert, animated: true, completion: nil)
    }
}
