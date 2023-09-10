//
//  ViewController.swift
//  storyLine
//
//  Created by Анастасия Рыбакова on 30.08.2023.
//

import UIKit

class ViewController: UIViewController {

// MARK: - UI
    
    private lazy var backgroundImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
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
    
    
    private lazy var storyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
//        label.font = .boldSystemFont(ofSize: 30)
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var firstButton: UIButton = {
        let element = UIButton(type: .system)
        element.layer.cornerRadius = 20
        element.titleLabel?.font = .systemFont(ofSize: 23)
        element.tintColor = .white
        element.titleLabel?.numberOfLines = 0
        element.titleLabel?.textAlignment = .center
        element.setBackgroundImage(UIImage(named: "choice1Background"), for: .normal)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var secondButton: UIButton = {
        let element = UIButton(type: .system)
        element.layer.cornerRadius = 20
        element.titleLabel?.font = .systemFont(ofSize: 23)
        element.tintColor = .white
        element.titleLabel?.numberOfLines = 0
        element.titleLabel?.textAlignment = .center
        element.setBackgroundImage(UIImage(named: "choice2Background"), for: .normal)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
   
    
// MARK: - Private propertiez
    
    private var storyBrain = StoryBrain()
    private var delayTime = 0.3
    private var timer = Timer()
    
    
// MARK: Life Sycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupConstraints()
        self.updateUI()
    }

// MARK: - Private Methodes
    
    private func setupViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(storyLabel)
        mainStackView.addArrangedSubview(firstButton)
        mainStackView.addArrangedSubview(secondButton)
        
        storyLabel.text = "Question"
        
        firstButton.addTarget(self, action: #selector(choiceMade(_:)), for: .touchUpInside)
        
        secondButton.addTarget(self, action: #selector(choiceMade(_:)), for: .touchUpInside)
    }
    
    
    @objc private func updateUI() {
        storyLabel.text = storyBrain.getLabelText
        firstButton.setTitle(storyBrain.getButton1Text, for: .normal)
        secondButton.setTitle(storyBrain.getButton2Text, for: .normal)
    }
    
    @objc private func choiceMade(_ sender: UIButton) {
        print("button tapped")
        
        guard let chioce = sender.currentTitle else {
            print("Title error")
            return
        }
        
        storyBrain.nextStory(chioce)
        
        timer = Timer.scheduledTimer(timeInterval: delayTime, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        
    }
    

}


// MARK: - Extension

extension ViewController {
    
    private func setupConstraints() {
        
        let constraints: [NSLayoutConstraint] = [
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            firstButton.heightAnchor.constraint(equalToConstant: 100),
            secondButton.heightAnchor.constraint(equalToConstant: 100),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}

