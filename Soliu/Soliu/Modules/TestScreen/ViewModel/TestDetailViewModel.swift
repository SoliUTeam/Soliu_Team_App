//
//  TestDetailViewModel.swift
//  Soliu
//
//  Created by JungpyoHong on 8/28/21.
//
import Firebase
import Foundation

class TestDetailViewModel {
    
    // testQuestion : contain test question data in testQuestion json file
    private var testQuestion = [TestQuestion]()
    private var currentQuestionCount = 1
    
    // upload data to firebase
    func uploadData() {
        print("uploaded successful!!")
    }
    
    func populateTestQuestionDataFromJson(number count: Int) {
        if let path = Bundle.main.path(forResource: "testQuestion" + "\(count)", ofType: "json") {
            do {
                let dataJson = try Data(contentsOf: URL(fileURLWithPath: path))
                let jsonDict = try JSONSerialization.jsonObject(with: dataJson, options: .mutableContainers)
                if let jsonResults = jsonDict as? [String: Any],
                   let results = jsonResults["testQuestion" + "\(count)"] as? [[String: Any]],
                   let questionNumber = jsonResults["totalQuestionNumber"] as? Int {
                    results.forEach { dict in
                        self.testQuestion.append(TestQuestion(question: dict["question"] as? String ?? "No Question Available", totalQuestionNumber: questionNumber))
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    func getProgress() -> Float {
        return Float(currentQuestionCount) / Float(testQuestion.count - 1)
    }
    
    func getQuestionText() -> String {
        return testQuestion[currentQuestionCount - 1].question
    }
    
    func nextQuestion() {
           if currentQuestionCount + 1 < testQuestion.count + 1 {
            currentQuestionCount += 1
           } else {
            currentQuestionCount = 1
           }
       }
    
    func getTotalQuestion() -> String {
        "\(testQuestion[0].totalQuestionNumber)"
    }
}
