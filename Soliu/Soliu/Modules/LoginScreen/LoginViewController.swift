//
//  LoginViewController.swift
//  Soliu
//
//  Created by Yoonha Kim on 8/30/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func login() {
        
        guard let id = idTextField.text,
              let password = passwordTextField.text else { return }
        Auth.auth().signIn(withEmail: id, password: password) { result, error in
            if error != nil {
                print("Error nil")
            }
        }
    }
    
    @IBAction private func openRegisterView() {
            self.performSegue(withIdentifier: "openRegisterView", sender: nil)
            print("openRegisterView")
        }
}
