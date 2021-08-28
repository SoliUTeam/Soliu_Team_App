//
//  TestQuestion.swift
//  Soliu
//
//  Created by JungpyoHong on 8/28/21.
//

import Foundation

struct TestQuestion {
    var question: String
    var questionNumber: Int
    
    enum CodingKeys: String, CodingKey {
        case question
        case questionNumber = "question_number"
    }
}
