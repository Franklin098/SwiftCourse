//
//  Question.swift
//  Quizzler
//
//  Created by Franklin Velásquez Fuentes on 7/9/19.
//

import Foundation

class Question {
    
    let questionText : String
    let answer : Bool
    
    init(text:String , correctAnswer:Bool) {
        questionText = text
        answer = correctAnswer
    }
    
}
