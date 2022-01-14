import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift


class SupportFirebase {
    static let supportFirebase = SupportFirebase()
    private init() { }
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
    
    func updateTestScore(testScore: [Int]) {
        let dateString = Date().iso8601withFractionalSeconds
        let savedDictionaryArray: [String: Any] = ["testScore": testScore, "testDate": dateString]
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

extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options) {
        self.init()
        self.formatOptions = formatOptions
    }
}

extension Date {
    var iso8601withFractionalSeconds: String { return Formatter.iso8601withFractionalSeconds.string(from: self) }
}

extension Formatter {
    static let iso8601withFractionalSeconds = ISO8601DateFormatter([.withInternetDateTime])
}

extension String {
    var iso8601withFractionalSeconds: Date? { return Formatter.iso8601withFractionalSeconds.date(from: self)}
}
