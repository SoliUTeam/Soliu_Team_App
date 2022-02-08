import Foundation
import Firebase

class ProfileViewModel {
    
    var testInformation: TestInformation?
    var currentUser: String
    let db = Firestore.firestore()
    

    
    init() {
        currentUser = Auth.auth().currentUser?.uid ?? ""
        self.readTestResult { }

    }
    
    func readTestResult(_ completion: () -> Void )  {
        
        db.collection("userInfo").document(currentUser).addSnapshotListener { [weak self] document, error in
            guard let self = self else { return }
            if error != nil {
                print("reading error")
            }
            DispatchQueue.main.async {
                let data = document?.data()
                guard let majorIn = data?["major"] as? String, let gradeIn = data?["grade"] as? String, let genderIn = data?["gender"] as? String else { return }
                
                self.testInformation = TestInformation(gender: genderIn, grade: gradeIn, major: majorIn, testResult: [])
            }
        }
    }
    
    func getTestScore() -> [Int] {
        var depressionScore: Int = 0
        var anxietyScore: Int = 0
        var stressScore: Int = 0
        
        guard let testResult = testInformation?.testResult else { return
            [0,0,0]
        }
        
        for n in testResult {
            for index in 0...15 {
                switch index {
                case 0...4:
                    depressionScore += n.testScore[index]
                    break
                    
                case 5...10:
                    anxietyScore += n.testScore[index]
                    break
                    
                default:
                    stressScore += n.testScore[index]
                }
            }
        }
        return [depressionScore, anxietyScore, stressScore]
    }
}
