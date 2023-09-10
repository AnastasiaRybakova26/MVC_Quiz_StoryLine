//
//  Question.swift
//  Quizzler_3Answer
//
//  Created by Анастасия Рыбакова on 21.08.2023.
//

import Foundation

struct Question {
    let text: String
    let answer: [String]
    let correctAnswer: String
    
    init(q: String, a: [String], correctAnswer: String) {
        self.text = q
        self.answer = a
        self.correctAnswer = correctAnswer
    }
}
