import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift


class SupportFirebase {
    static let supportFirebase = SupportFirebase()
    private init() {
        
    }
    let userInfo = "userInfo"
    let db = Firestore.firestore()
    let currentUser = Auth.auth().currentUser?.uid ?? ""
    var testInformation: TestInformation?
    
    func isLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    func readTestResult() -> TestInformation? {
        db.collection("userInfo").document(currentUser).addSnapshotListener { document, error in
            if error != nil {
                print("reading error")
            }
            if let document = document {
                do {
                    self.testInformation = try JSONDecoder().decode(TestInformation.self, from: JSONSerialization.data(withJSONObject: document.data() as Any))
                    dump(self.testInformation!)
                }
                catch {
                    print("Read error") }
            }
        }
        return testInformation
    }
    
    func updateTestScore(testScore: [Int], testDate: String) {
        let savedDictionaryArray: [String: Any] = ["testScore": testScore, "testDate": testDate]
        let ref = db.collection("userInfo").document(currentUser)
        ref.updateData([
            "testResult": FieldValue.arrayUnion([savedDictionaryArray])]
        )
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            print("Sign Out error \(error.localizedDescription)")
        }
    }
}
