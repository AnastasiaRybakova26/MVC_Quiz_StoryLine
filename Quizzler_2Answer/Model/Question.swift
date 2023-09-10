//
//  Question.swift
//  Quizzler_2Answer
//
//  Created by Анастасия Рыбакова on 28.08.2023.
//

import Foundation

struct Question {
    let question: String
    let answer: String
    
    init(q: String, a: String) {
        self.question = q
        self.answer = a
    }
}
