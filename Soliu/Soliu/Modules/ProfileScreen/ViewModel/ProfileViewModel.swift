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
                        print("Error")
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
        depressionScore = (Double(depressionScore / 5))
        anxietyScore = Double(anxietyScore / 5)
        stressScore = Double(stressScore / 5)

        return [depressionScore, anxietyScore, stressScore]
    }
}
