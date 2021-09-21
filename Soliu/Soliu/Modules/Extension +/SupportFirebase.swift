//
//  Firebase+Extension.swift
//  Soliu
//
//  Created by Yoonha Kim on 9/20/21.
//

import Foundation
import Firebase

class SupportFirebase {
    
    static func isLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    
}
