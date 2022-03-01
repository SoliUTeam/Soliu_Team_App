import Foundation
import Firebase
import UIKit

protocol ProfileViewModelDelegate: AnyObject {
    func reloadData(averageScore: AverageTestScore)
}

class ProfileViewModel {
    
    var testInformation: TestInformation?
    var allTestResult: AllTestResult?
    var currentUser: String
    let db = Firestore.firestore()
    weak var delegate: ProfileViewModelDelegate?
    
    init(delegate: ProfileViewModelDelegate) {
        self.delegate = delegate
        currentUser = Auth.auth().currentUser?.uid ?? ""
    }
    
    func readTestResult() {
        self.getUserTestData()
        self.getUserAllData()
        self.calculateTestScore(testInformation: self.testInformation, allTestResult: self.allTestResult)
    }
    
    func getUserTestData() {
        db.collection("userInfo").document(currentUser).getDocument { [weak self] document, error in
            guard let self = self else { return }
            if error != nil {
                print("Fails to get document userTestData")
            }
            DispatchQueue.main.async {
                do {
                    let retrievedTestInformation = try document?.data(as: TestInformation.self)
                    self.testInformation = retrievedTestInformation
                }
                catch {
                    self.testInformation =  self.defaultTestScore
                    print("Fails to read TestInformation")
                
                }
            }
        }
    }
    
    func getUserAllData() {
        db.collection("userInfo").document("All_Test_Score").getDocument { [weak self] document, error in
            guard let self = self else { return }
            if error != nil {
                print("Fails to read document All Test")
            }
            DispatchQueue.global().async {
                do {
                    let retrievedTestResult = try document?.data(as: AllTestResult.self)
                    self.allTestResult = retrievedTestResult
                }
                catch {
                    self.testInformation =  self.defaultTestScore
                    print("Fails to read All Test")
                }
            }
        }
    }
    
    func calculateTestScore(testInformation: TestInformation?, allTestResult: AllTestResult?) {
        guard let testInformation = testInformation else {
            return
        }

        let userAverageScore = calculateUserAverageScore(testInformation: testInformation)
        let allUserAverageScore = calculateAllUserAverageScore(allTestResult: allTestResult ?? defaultAllTestScore)
        let testScoreList = userAverageScore + allUserAverageScore
        self.delegate?.reloadData(averageScore: AverageTestScore(scoreList: testScoreList))
    }
    
    func calculateUserAverageScore(testInformation: TestInformation) -> [Double] {
        let testResultList = testInformation.testResult
        var depressionScore: Double = 0
        var anxietyScore: Double = 0
        var stressScore: Double = 0
        
        for n in testResultList {
            for index in 0...14 {
                switch index {
                case 0...4:
                    depressionScore += Double(n.testScore[index])
                    break
                    
                case 5...10:
                    anxietyScore += Double(n.testScore[index])
                    break
                    
                default:
                    stressScore += Double(n.testScore[index])
                }
            }
        }
        depressionScore = Double(Int(depressionScore) / 5 / testResultList.count)
        anxietyScore = Double(Int(anxietyScore) / 5 /  testResultList.count)
        stressScore = Double(Int(stressScore) / 5 / testResultList.count)
        
        return [depressionScore, anxietyScore, stressScore]
    }
    
    func calculateAllUserAverageScore(allTestResult: AllTestResult) -> [Double] {
        let allTestResult = allTestResult.testResult
        var depressionScore: Double = 0
        var anxietyScore: Double = 0
        var stressScore: Double = 0
        
        for n in allTestResult {
            for index in 0...14 {
                switch index {
                case 0...4:
                    depressionScore += Double(n.testScore[index])
                    break
                    
                case 5...10:
                    anxietyScore += Double(n.testScore[index])
                    break
                    
                default:
                    stressScore += Double(n.testScore[index])
                }
            }
        }
        depressionScore = Double(Int(depressionScore) / allTestResult.count)
        anxietyScore = Double(Int(anxietyScore) / allTestResult.count)
        stressScore = Double(Int(stressScore) / allTestResult.count)
        
        return [depressionScore, anxietyScore, stressScore]
    }
}

extension ProfileViewModel {
    var defaultTestScore: TestInformation {
        TestInformation(gender: "not provided", grade: "not provided", major: "not major", testResult: [TestResult(testDate: "", testScore: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14])])
    }
    
    var defaultAllTestScore: AllTestResult {
        return AllTestResult(testResult: [TestResultWithUid(testDate: "", testScore: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14], testUid: "testUid")])
        
    }
}

