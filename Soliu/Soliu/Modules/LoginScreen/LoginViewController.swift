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
        
        Auth.auth().signIn(withEmail: id, password: password) { (result, error) in
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                    case .operationNotAllowed:
                        self.displayMessage(with: "Server Issue", message: "Currently, our server has issues.\nPlease try again later.")
                    case .userDisabled:
                        self.displayMessage(with: "Email Issue", message: "We can't find your email.\nPlease check your email")
                    case .wrongPassword:
                        self.displayMessage(with: "Wrong Password", message: "Your password word is incorrect\nPlease try another password")
                    case .invalidEmail:
                        self.displayMessage(with: "Email Issue", message: "We can't find your email.\nPlease check your email")

                   default:
                       print("Error: \(error.localizedDescription)")
                   }
            }
            else {
                self.openProfileView()
            }
        }
    }

    @IBAction private func openRegisterView() {
            self.performSegue(withIdentifier: "openRegisterView", sender: nil)
        }
    
    private func openProfileView() {
        self.performSegue(withIdentifier: "openProfileView", sender: nil)
    }
    
}
