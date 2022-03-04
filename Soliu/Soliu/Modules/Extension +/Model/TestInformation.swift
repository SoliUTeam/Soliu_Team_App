//
//  UserInformation.swift
//  Soliu
//
//  Created by Yoonha Kim on 10/5/21.
//

import Foundation
import Lottie

struct TestInformation: Codable {
    var gender: String
    var grade: String
    var major: String
    var testResult: [TestResult]
    
    enum CodingKeys: String, CodingKey {
        case gender
        case grade
        case major
        case testResult
    }
}

struct TestResult: Codable {
    var testDate: String
    var testScore: [Int]
    
    enum CodingKeys: String, CodingKey {
        case testDate
        case testScore
    }
}

struct AllTestResult: Codable {
    var testResult: [TestResultWithUid]
    
}

struct TestResultWithUid: Codable {
    var testDate: String
    var testScore: [Int]
    var testUid: String
}


var depressionScore: Double = 0
var anxietyScore: Double = 0
var stressScore: Double = 0

struct AverageTestScore {
    
    var userAverageDepressionScore: Double
    var userAverageAnxietyScore: Double
    var userAverageStressScore: Double
    
    var allUserAverageDepressionScore: Double
    var allUserAverageAnxietyScore: Double
    var allUserAverageStressScore: Double
    
    init(scoreList: [Double]) {
        self.userAverageDepressionScore = scoreList[0]
        self.userAverageAnxietyScore = scoreList[1]
        self.userAverageStressScore = scoreList[2]
        
        self.allUserAverageDepressionScore = scoreList[3]
        self.allUserAverageAnxietyScore = scoreList[4]
        self.allUserAverageStressScore = scoreList[5]
    }
}
