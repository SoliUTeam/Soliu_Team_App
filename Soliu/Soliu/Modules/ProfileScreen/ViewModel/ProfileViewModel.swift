import Foundation
import Firebase
import UIKit

protocol ProfileViewModelDelegate: AnyObject {
    func reloadData(testInformation: TestInformation?)
}

class ProfileViewModel {
    
    var testInformation: TestInformation?
    var currentUser: String
    let db = Firestore.firestore()
    weak var delegate: ProfileViewModelDelegate?

    init(delegate: ProfileViewModelDelegate) {
        self.delegate = delegate
        currentUser = Auth.auth().currentUser?.uid ?? ""
    }
    
    
    func readTestResult() {
    
        db.collection("userInfo").document(currentUser).getDocument { [weak self] document, error in
            guard let self = self else { return }
            if error != nil {
                print("Fails to read error")
            }
            
            DispatchQueue.main.async {
                    do {
                        let retrievedTestInformation = try document?.data(as: TestInformation.self)
                        self.testInformation = retrievedTestInformation
                        self.delegate?.reloadData(testInformation: retrievedTestInformation)
                    }
                    catch {
                        self.testInformation =  self.defaultTestScore
                        print("Fails to read Data")
                    }
            }
        }
    }
        
    func getTestScore() -> [Double] {
        var depressionScore: Double = 0
        var anxietyScore: Double = 0
        var stressScore: Double = 0
        
        guard let testResult = testInformation?.testResult else { return
            [0,0,0]
        }
        
        for n in testResult {
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
        depressionScore = (Double(Int(depressionScore) / 5 / testResult.count))
        anxietyScore = Double(Int(anxietyScore) / 5 /  testResult.count)
        stressScore = Double(Int(stressScore) / 5 / testResult.count)

        return [depressionScore, anxietyScore, stressScore]
    }
}

extension ProfileViewModel {
    var defaultTestScore: TestInformation {
        return
        TestInformation(gender: "not provided", grade: "not provided", major: "not major", testResult: [TestResult(testDate: "", testScore: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15])])
    }
}
