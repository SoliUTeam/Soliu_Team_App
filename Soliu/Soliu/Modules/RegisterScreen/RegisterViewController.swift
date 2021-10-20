//
//  RegisterViewController.swift
//  Soliu
//
//  Created by Yoonha Kim on 8/30/21.
//

import UIKit
import Firebase
import FirebaseFirestore

class RegisterViewController: UIViewController, AlertProtocol {
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var gradeSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var majorTextField: UITextField!
    
    let database = Firestore.firestore()
    
    
    private var isRegisterReady: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                self.writeData(uid: authResult?.user.uid ?? "")
                self.registerAlertViewController()
            }
        }
    }
    
    func writeData(uid: String) {
        let userInfo = "userInfo"
        guard let genderInfo = genderSegmentedControl.titleForSegment(at: genderSegmentedControl.selectedSegmentIndex),
              let gradeInfo = gradeSegmentedControl.titleForSegment(at: gradeSegmentedControl.selectedSegmentIndex),
              let majorInfo = majorTextField.text else { return }
        let emptyTestResult = ["testScore" : [], "testDate" : ""] as [String : Any]
        self.database.collection(userInfo).document(uid).setData([SupportString.gender: genderInfo,
                                                                  SupportString.grade: gradeInfo,
                                                                  SupportString.major: majorInfo,
                                                                  SupportString.testResult: [emptyTestResult]
                                                                  ],
                                                    merge: false)
    }
    
    func registerAlertViewController() {
        let alert = UIAlertController(title: "Register Successfully", message: "Your sign-up confirms successfully.", preferredStyle: .alert)
        let registerAction = UIAlertAction(title: "Okay", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(registerAction)
        self.present(alert, animated: true)
    }
}
