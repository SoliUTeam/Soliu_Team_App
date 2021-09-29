//
//  NewStartTestScreenViewController.swift
//  Soliu
//
//  Created by JungpyoHong on 9/28/21.
//

import Foundation
import UIKit
import Firebase

class NewStartTestScreenViewController: UIViewController {
    
    @IBOutlet private weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isLoggedIn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.isLoggedIn()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.dismiss(animated: animated, completion: nil)
    }
}
    
extension NewStartTestScreenViewController: TestScreenControllable {
    
    func isLoggedIn() {
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "testLoginScreen", sender: nil)
        }
    }
    
    func isLoggedIn(completionHandler: (Bool) -> ()) {
        isLoggedIn()
        completionHandler(Auth.auth().currentUser != nil)
    }
}

extension NewStartTestScreenViewController: TestScreenViewModelDelegate {
    
    func reload() {
        //NO reload needed
    }
}
