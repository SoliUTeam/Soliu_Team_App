//
//  UserInformation.swift
//  Soliu
//
//  Created by Yoonha Kim on 10/5/21.
//

import Foundation

struct TestInformation: Decodable {
    var gender: String
    var grade: String
    var major: String
    var testResult: [TestResult]
}

struct TestResult:  Decodable {
    var testDate: String
    var testScore: [Int]
}
