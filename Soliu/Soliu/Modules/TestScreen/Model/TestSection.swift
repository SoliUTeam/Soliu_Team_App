//
//  TestSection.swift
//  Soliu
//
//  Created by JungpyoHong on 8/24/21.
//

import Foundation
import UIKit

struct TestSection {
    var thumbImage: String
    var title: String
    var color: String
    var testNumber: Int
    
    enum CodingKeys: String, CodingKey {
        case thumbImage, title, color
        case test_number = "testNumber"
    }
}
