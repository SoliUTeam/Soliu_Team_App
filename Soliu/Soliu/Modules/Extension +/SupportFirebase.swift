//
//  Firebase+Extension.swift
//  Soliu
//
//  Created by Yoonha Kim on 9/20/21.
//

import Foundation
import Firebase
import FirebaseFirestore



class SupportFirebase {
    
    static let userInfo = "userInfo"
    static let db = Firestore.firestore()
    static let currentUser = Auth.auth().currentUser?.uid ?? ""
    static var testInformation: TestInformation?

    static func isLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    static func readData() -> TestInformation? {

        db.collection("userInfo").document(currentUser).addSnapshotListener { document, error in
            if error != nil {
                print("reading error")
            }
            if let document = document {
                do {
                    testInformation = try JSONDecoder().decode(TestInformation.self, from: JSONSerialization.data(withJSONObject: document.data())
                    )
                }
                catch {
                    print("Read error") }
            }
        }
            
        return testInformation
    }
    
    static func writeData(testDate: String, testScore: [Int]) {
        var userTestInformation = readData()
        let testResult = TestResult(testDate: testDate, testScore: testScore)
        userTestInformation?.testResult.append(testResult)
        db.collection("userInfo").document(currentUser).setData(["testResult" : testResult])
    }
}
