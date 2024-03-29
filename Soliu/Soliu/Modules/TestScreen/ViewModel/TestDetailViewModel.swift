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
    private let db = Firestore.firestore()
    var ref: DatabaseReference = Database.database().reference()
    
    func uploadData(testScore: [Double]) {
        var depression: Double = 0
        var anxiety: Double = 0
        var stress: Double = 0
        
        for score in testScore[0...4] {
            depression += score
        }
        depression = depression / 3
        
        for score in testScore[5...9] {
            anxiety += score
        }
        
        anxiety = anxiety / 3
        
        for score in testScore[10...14] {
            stress += score
        }
        stress = stress / 3
        
        let user = Auth.auth().currentUser
        
        ref.childByAutoId()
        guard let userID = user?.uid else { return }
        
        self.ref.child("newUsers").child(userID).setValue(["depression": depression, "anxiety": anxiety, "stress": stress])
        
        //        self.db.collection("users").addDocument(data: ["depression": depression, "anxiety": anxiety, "stress": stress, "uid": user?.uid]) { error in
        //            if error != nil {
        //                print("data store error")
        //            } else {
        //                print("Dennis")
        //            }
        //        }
    }
    
    func getUserScoreData() {
        
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
    
    func getTotalQuestion() -> Int {
        testQuestion[0].totalQuestionNumber
    }
}

