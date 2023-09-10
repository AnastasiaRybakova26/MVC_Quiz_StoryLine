//
//  ViewController.swift
//  Quizzler_2Answer
//
//  Created by Анастасия Рыбакова on 21.08.2023.
//

import UIKit

class ViewController: UIViewController {
    
// MARK: - UI Properties
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Background-Bubbles")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillProportionally
        stack.alignment = .fill
//        stack.backgroundColor = .white.withAlphaComponent(0.5)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
//        label.textAlignment = .left
        label.numberOfLines = 0
//        label.font = .boldSystemFont(ofSize: 30)
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var firstButton: UIButton = {
        let element = UIButton(type: .system)
        element.titleLabel?.font = .systemFont(ofSize: 25)
        element.layer.cornerRadius = 20
        element.tintColor = .white
        element.setBackgroundImage(UIImage(named: "Rectangle"), for: .normal)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var secondButton: UIButton = {
        let element = UIButton(type: .system)
        element.titleLabel?.font = .systemFont(ofSize: 25)
        element.layer.cornerRadius = 20
        element.tintColor = .white
        element.setBackgroundImage(UIImage(named: "Rectangle"), for: .normal)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
    private lazy var progressBar: UIProgressView = {
        let element = UIProgressView()
        element.progressTintColor = UIColor(red: 1.0, green: 0.46, blue: 0.66, alpha: 1)
        element.trackTintColor = .white
        element.progress = 0.5
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
// MARK: - Private properties
    private var quizBrain = QuizBrain()
    private let delayTime = 0.3
    private var timer = Timer()

// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraints()
        self.updateUI()
    }

// MARK: - Private Methodes
    
    private func setupView() {
        view.backgroundColor = UIColor(red: 37/255, green: 44/255, blue: 74/255, alpha: 1)
        view.addSubview(backgroundImageView)
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(scoreLabel)
        mainStackView.addArrangedSubview(questionLabel)
        mainStackView.addArrangedSubview(firstButton)
        mainStackView.addArrangedSubview(secondButton)
        mainStackView.addArrangedSubview(progressBar)
        
        scoreLabel.text = "Score: "
        questionLabel.text = "Question"
        
        firstButton.setTitle("True", for: .normal)
        firstButton.addTarget(self, action: #selector(answerButtonTapped), for: .touchUpInside)
        
        secondButton.setTitle("False", for: .normal)
        secondButton.addTarget(self, action: #selector(answerButtonTapped), for: .touchUpInside)
    }
    
    @objc private func answerButtonTapped(_ sender: UIButton) {
        guard let answer = sender.currentTitle else {
            print("Current Title error")
            return
        }
        
        // Меняем увет кнопки в зависимости от правильности ответа
        let check = quizBrain.checkAnswer(answer)
        sender.backgroundColor = check ? .systemGreen : .systemRed
        
        quizBrain.nextQuection()
        
        timer = Timer.scheduledTimer(timeInterval: delayTime,
                                     target: self,
                                     selector: #selector(updateUI),
                                     userInfo: nil,
                                     repeats: false)
    }
    
    // После
    @objc private func updateUI() {
        
        firstButton.backgroundColor = UIColor.clear
        secondButton.backgroundColor = UIColor.clear
        
        questionLabel.text = quizBrain.getQuestionText
        progressBar.setProgress(quizBrain.getProgress, animated: true)
        scoreLabel.text = "Score: \(quizBrain.getScore())"
    }

}



// MARK: - Extensions

extension ViewController {

    
    private func setupConstraints() {
        
        let constraints: [NSLayoutConstraint] = [
            backgroundImageView.heightAnchor.constraint(equalToConstant: 102),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            firstButton.heightAnchor.constraint(equalToConstant: 80),
            secondButton.heightAnchor.constraint(equalToConstant: 80),
            progressBar.heightAnchor.constraint(equalToConstant: 5),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
