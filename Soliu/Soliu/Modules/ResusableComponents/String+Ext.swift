//
//  String Ext++.swift
//  Soliu
//
//  Created by Yoonha Kim on 6/20/21.
//

import Foundation


extension Date {
    
    func getDateString(using format: String) -> String {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        return formatter.string(from: currentDateTime)
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
