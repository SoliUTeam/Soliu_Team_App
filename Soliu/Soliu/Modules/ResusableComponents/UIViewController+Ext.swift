//
//  UIViewController Ext++.swift
//  Soliu
//
//  Created by Yoonha Kim on 6/21/21.
//

import UIKit

extension UIViewController {
    
    func displayMessage(with title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title:"OK", style: .default))
        self.present(ac, animated: true)
    }
}
