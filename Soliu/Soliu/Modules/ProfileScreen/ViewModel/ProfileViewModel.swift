import Foundation
import Firebase
import UIKit

protocol ProfileViewModelDelegate: AnyObject {
    func reloadData(averageScore: AverageTestScore)
}

class ProfileViewModel {
    
    var testInformation: TestInformation?
    var allTestResult: AllTestResult?
    let db = Firestore.firestore()
    weak var delegate: ProfileViewModelDelegate?
    
    init(delegate: ProfileViewModelDelegate) {
        self.delegate = delegate
    }
    
    func readTestResult() {
        let group = DispatchGroup()
        group.enter()
        self.getUserTestData { success, testInformation in
            if success {
            self.testInformation = testInformation
            }
            else {
                self.testInformation = self.defaultTestScore
            }
            group.leave()
        }
        group.enter()
        self.getUserAllData { success, allTestResult in
            if success {
            self.allTestResult = allTestResult
            }
            else {
                self.allTestResult = self.defaultAllTestScore
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.calculateTestScore()
        }
    }
    
    func getUserTestData(completionBlock:
                         @escaping (_ success: Bool, _ testInformation: TestInformation?) -> Void) {
        var currentUser = Auth.auth().currentUser?.uid ?? "noData"
        db.collection("userInfo").document(currentUser).getDocument { document, error in
            if error != nil {
                print("Fails to get document userTestData")
            }
            do {
                let retrievedTestInformation = try document?.data(as: TestInformation.self)
                completionBlock(true, retrievedTestInformation)
            }
            catch {
                completionBlock(false, nil)
            }
        }
    }
    
    func getUserAllData(completionBlock:
                        @escaping (_ success: Bool, _ allTestResult: AllTestResult?) -> Void) {
        var currentUser = Auth.auth().currentUser?.uid ?? "noData"
        db.collection("userInfo").document("All_Test_Score").getDocument { document, error in
            if error != nil {
                print("Fails to read document All Test")
            }
            do {
                let retrievedTestResult = try document?.data(as: AllTestResult.self)
                completionBlock(true, retrievedTestResult)
            }
            catch {
                completionBlock(false, nil)
                print("Fails to read All Test")
            }
            
        }
    }
    
    func calculateTestScore() {
        let userAverageScore = calculateUserAverageScore(testInformation: self.testInformation ?? defaultTestScore)
        let allUserAverageScore = calculateAllUserAverageScore(allTestResult: self.allTestResult ?? defaultAllTestScore)
        let testScoreList = userAverageScore + allUserAverageScore
        var userInfoList = [self.testInformation?.gender, self.testInformation?.grade, self.testInformation?.major]
        self.delegate?.reloadData(averageScore: AverageTestScore(scoreList: testScoreList, userInformation: userInfoList))
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
        depressionScore = depressionScore / Double(5) / Double(testResultList.count)
        anxietyScore =  anxietyScore / Double(5) /  Double(testResultList.count)
        stressScore = stressScore / Double(5) / Double(testResultList.count)
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
        depressionScore = depressionScore / Double(allTestResult.count) / Double(5)
        anxietyScore = anxietyScore / Double(allTestResult.count) / Double(5)
        stressScore = stressScore / Double(allTestResult.count) / Double(5)
        
        return [depressionScore, anxietyScore, stressScore]
    }
}

extension ProfileViewModel {
    var defaultTestScore: TestInformation {
        TestInformation(gender: "not provided", grade: "not provided", major: "not major", testResult: [TestResult(testDate: "", testScore: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])])
    }
    
    var defaultAllTestScore: AllTestResult {
        return AllTestResult(testResult: [TestResultWithUid(testDate: "", testScore: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], testUid: "testUid")])
    }
}
