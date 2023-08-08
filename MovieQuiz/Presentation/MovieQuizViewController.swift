import UIKit
// Основной класс приложения
final class MovieQuizViewController: UIViewController {
    
    @IBOutlet weak private var textLabel: UILabel!
    @IBOutlet weak private var counterLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak private var noButton: UIButton!
    @IBOutlet weak private var yesButton: UIButton!
    
    // MARK: - Variables
    
    // Счетчик вопросов
    private var currentQuestionIndex: Int = 0
    // Количество правильных ответов
    private var correctAnswers: Int = 0
    
    // Структура для конвертации вопросов с мока
    private struct QuizQuestion {
        let image: String
        let text: String
        let correctAnswer: Bool
    }
    // Вью модель для состояния "вопрос показан"
    private struct QuizStepViewModel{
        let image: UIImage
        let question: String
        let questionNumber: String
    }
    // Структура для работы алерта
    private struct QuizResultsViewModel{
        let title: String
        let text: String
        let buttonText: String
    }
    // Моки для данных квиза
    private let questions: [QuizQuestion] = [
        QuizQuestion(
            image:"The Godfather",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Dark Knight",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "Kill Bill",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Avengers",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "Deadpool",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Green Knight",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "Old",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "The Ice Age Adventures of Buck Wild",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "Tesla",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "Vivarium",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        
    ]
    
    
    
    // MARK: - Functions
    
    
    // Lifecycle
    override func viewDidLoad() {
        let currentQuestion = questions[currentQuestionIndex]
        imageView.layer.cornerRadius = 20
        super.viewDidLoad()
        show(quiz: convert(model: currentQuestion))
    }
    // Метод для конвертации вопросов из мока
    private func convert(model: QuizQuestion) -> QuizStepViewModel{
        return QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questions.count)")
    }
    // Метод для отображения вопросов
    private func show(quiz step: QuizStepViewModel){
        counterLabel.text = step.questionNumber
        textLabel.text = step.question
        imageView.image = step.image
        self.yesButton.isEnabled = true
        self.noButton.isEnabled = true
        
    }
    // Метод для отображения рамки правильного или неправильного ответа
    private func showAnswerResult(isCorrect: Bool) {
        if isCorrect{
            correctAnswers += 1
            //здесь присутвует защита от прокликивания
            self.yesButton.isEnabled = false
            self.noButton.isEnabled = false
            
            imageView.layer.masksToBounds = true
            imageView.layer.borderWidth = 8
            imageView.layer.cornerRadius = 20
            imageView.layer.borderColor = isCorrect ? UIColor(named: "YPGreen")?.cgColor : UIColor(named: "YPGreen")?.cgColor
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.showNextQuestionOrResults()
            }
        }else{
            self.yesButton.isEnabled = false
            self.noButton.isEnabled = false
            
            imageView.layer.masksToBounds = true
            imageView.layer.borderWidth = 8
            imageView.layer.cornerRadius = 20
            imageView.layer.borderColor = isCorrect ? UIColor(named: "YPRed")?.cgColor : UIColor(named: "YPRed")?.cgColor
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.showNextQuestionOrResults()
            }
        }
        
        
    }
    // Метод логики перехода в один из сценариев
    private func showNextQuestionOrResults() {
        if currentQuestionIndex == questions.count - 1{
            let text = "Ваш результат: \(correctAnswers) из 10"
            let viewModel = QuizResultsViewModel(
                title: "Этот раунд окончен!",
                text: text,
                buttonText: "Сыграть ещё раз")
            imageView.layer.borderWidth = 0
            show(quiz: viewModel)
        }else{
            currentQuestionIndex += 1
            let nexQuestion = questions[currentQuestionIndex]
            let viewModel = convert(model: nexQuestion)
            imageView.layer.borderWidth = 0
            show(quiz: viewModel)
        }
    }
    // Метод работы с результатами квиза
    private func show(quiz result: QuizResultsViewModel) {
        let alert = UIAlertController(
            title: result.title,
            message: result.text,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: result.buttonText, style: .default) {_ in
            self.currentQuestionIndex = 0
            
            // скидываем счётчик правильных ответов
            self.correctAnswers = 0
            
            // заново показываем первый вопрос
            let firstQuestion = self.questions[self.currentQuestionIndex]
            let viewModel = self.convert(model: firstQuestion)
            self.show(quiz: viewModel)
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    // MARK: - Actions
    
    // Кнопка ответа - "Нет"
    @IBAction func noButtonClicked(_ sender: UIButton) {
        let currentQuestion = questions[currentQuestionIndex]
        let givenAnswer = false
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    
    
    // Кнопка ответа - "Да"
    @IBAction func yesButtonClicked(_ sender: UIButton) {
        let currentQuestion = questions[currentQuestionIndex]
        let givenAnswer = true
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    
    
}


/*
 Mock-данные
 
 
 Картинка: The Godfather
 Настоящий рейтинг: 9,2
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Dark Knight
 Настоящий рейтинг: 9
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Kill Bill
 Настоящий рейтинг: 8,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Avengers
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Deadpool
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Green Knight
 Настоящий рейтинг: 6,6
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Old
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: The Ice Age Adventures of Buck Wild
 Настоящий рейтинг: 4,3
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: Tesla
 Настоящий рейтинг: 5,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: Vivarium
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 */
