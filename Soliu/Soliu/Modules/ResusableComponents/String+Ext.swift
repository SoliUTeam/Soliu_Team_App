//
//  String Ext++.swift
//  Soliu
//
//  Created by Yoonha Kim on 6/20/21.
//

import Foundation


extension Date {
    static let dateFormatter = DateFormatter()

    func getDateString(using format: String) -> String {
        type(of: self).dateFormatter.dateFormat = format
        return type(of: self).dateFormatter.string(from: self)
    }
}

extension String {
    func checkTheDate(firstDate: String, secondDate: String) -> Bool {
        if firstDate.compare(secondDate) == .orderedDescending {
            return false
        }
        return true
    }
}
