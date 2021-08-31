//
//  RegisterViewController.swift
//  Soliu
//
//  Created by Yoonha Kim on 8/30/21.
//

import UIKit
import Firebase
class RegisterViewController: UIViewController {
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction private func register() {
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
          if let error = error as? NSError {
            switch AuthErrorCode(rawValue: error.code) {
            case .operationNotAllowed:
              print("Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.")
            case .emailAlreadyInUse:
                print("The email address is already in use by another account")
            case .invalidEmail:
              print("Error: The email address is badly formatted.")
            case .weakPassword:
              print( "Error: The password must be 6 characters long or more."
              )
            default:
                print("Error: \(error.localizedDescription)")
            }
          } else {
            print("User signs up successfully")
//            let newUserInfo = Auth.auth().currentUser
//            let email = newUserInfo?.email
            
            self.dismiss(animated: true, completion: nil)
          }
        }
    }
    
}
