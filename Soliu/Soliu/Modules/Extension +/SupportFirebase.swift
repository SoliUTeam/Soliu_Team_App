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
    static var testResultArray: [[String: Any]] = [[:]]
    
    static func isLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    static func readData() {
//        db.collection("userInfo").document(currentUser).getDocument { document, error in
//            if error != nil {
//                print(error ?? "error")
//            }
//            if let documentData = document?.data() {
//                let documentData = documentData["testResult"]
//            } else { print("Failed to get Data") }
//        }
    }
    
    static func writeData(testDate: String, testScore: [Int]) {
//        db.collection("userInfo").document(currentUser).getDocument { document, error in
//            if error != nil {
//                print(error ?? "error")
//            }
//            if let documentData = document?.data() {
//                self.testResultArray = documentData["testResult"] as? [[String: Any]] ?? [[:]]
//
//            }
//        }
        
//        db.collection("userInfo").document(currentUser).updateData(["t" : Any])
//        db.collection("userInfo").document(currentUser).setData(["testResult" : extendedArray], merge: true)
    }
    
//    static func writeData(with date: String, scoreArray: [Int]) {
//        let userInfo = "userInfo"
//        let database = Firestore.firestore()
//        database.document("userInfo/\(currentUser)").collection("testResult").getDocuments { data, error in
//            if error != nil {
//                print(error?.localizedDescription)
//            }
//            guard let documentData = data?.documents else {
//                "Faild to read Data"
//                return
//            }
//            print(documentData)
//            print(data)
//        }
//        database.collection(userInfo).document(currentUser).collection("testResult").setValuesForKeys(["date" : date, "score" : scoreArray])
//    }
}
