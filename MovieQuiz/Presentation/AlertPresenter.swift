//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Дмитрий Герасимов on 24.08.2023.
//

import Foundation
import UIKit



 class AlertPresenter: AlertPresenterProtocol {
    private weak var AlertViewController: UIViewController?
    
    init(AlertViewController: UIViewController) {
        self.AlertViewController = AlertViewController
    }
    
    func showAlert(model: AlertModel) {
        let alert = UIAlertController(title: model.title, message: model.message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: model.buttonText, style: .default, handler: model.completion)
        
        alert.addAction(action)
        AlertViewController?.present(alert, animated: true)
    }
}
