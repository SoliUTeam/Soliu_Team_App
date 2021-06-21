//
//  String Ext++.swift
//  Soliu
//
//  Created by Yoonha Kim on 6/20/21.
//

import Foundation


extension String {
    
    func getCurrentDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
    
}
