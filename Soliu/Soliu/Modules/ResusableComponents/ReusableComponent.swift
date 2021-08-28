//
//  ReusableComponent.swift
//  Soliu
//
//  Created by JungpyoHong on 8/28/21.
//

import Foundation
import UIKit

enum ReusableComponent {
    static func alertMessage(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        return alert
    }
    
    static func addRadiusForView(_ view: UIView) {
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
    }
    
    static func addMoreRadiusForView(_ view: UIView) {
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
    }
    
    static func addRadiusForImage(_ view: UIView) {
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
    }
}
