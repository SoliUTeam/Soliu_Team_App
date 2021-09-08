//
//  RegisterViewController.swift
//  Soliu
//
//  Created by Yoonha Kim on 8/30/21.
//

import UIKit
import Firebase
class RegisterViewController: UIViewController, AlertProtocol {
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var gradeSegmentedControl: UISegmentedControl!
    
    let database = Firestore.firestore()
    
    
    private var isRegisterReady: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
//        let docRef = database.document("userInfo")
//        docRef.getDocument { snapShot, error in
//            guard let data = snapShot?.data(), error == nil else { return }
//            print(data)
//        }
    }
    
    // Write Function
    func writeData() {
    }
    
    @IBAction private func register() {
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            // Register with Error
            if let error = error as NSError? {
            switch AuthErrorCode(rawValue: error.code) {
            case .operationNotAllowed:
                self.displayMessage(with: "Server Issue", message: "Currently, our server has issues.\nPlease try again later.")
            case .emailAlreadyInUse:
                self.displayMessage(with: "Email Issue", message: "Your email has been used.\nPlease type another email")
            case .weakPassword:
                self.displayMessage(with: "Weak Password", message: "Your password word is weak\nPlease try another password")
            default:
                self.displayMessage(with: "System Error", message: "\(error.localizedDescription)\nPlease contact our customer service")
            }
          } else {
            // Register is successfully. // Getting data using gender
            self.displayMessage(with: "Register Successful", message: "Your sign-up confirms successfully.")
            self.database.collection("userInfo").document(authResult?.user.uid ?? "").setData(["gender": "male"], merge: true)
            self.dismiss(animated: true, completion: nil)
          }
        }
    }
    
}
