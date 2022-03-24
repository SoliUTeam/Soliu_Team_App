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
    @IBOutlet private weak var passwordTextField: UITextField! {
        didSet {
            self.passwordTextField.delegate = self
        }
    }
    @IBOutlet private weak var reEnterTextField: UITextField! {
        didSet {
            self.reEnterTextField.delegate = self
        }
    }
    @IBOutlet private weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var gradeSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var departmentTextField: UITextField!
    @IBOutlet private weak var departmentPickerView: UIPickerView! {
        didSet {
            self.departmentPickerView.delegate = self
        }
    }
    
    let database = Firestore.firestore()
    
    var majorList = ["College of Agriculture",
                    "College of Architecture, Design, and Construction",
                    "Raymond J. Harbert College of Business",
                    "College of Education",
                    "Samuel Ginn College of Engineering",
                    "School of Forestry and Wildlife Sciences",
                    "College of Human Sciences",
                    "College of Liberal Arts",
                    "School of Nursing",
                    "School of Pharmacy",
                    "College of Sciences and Mathematics",
                    "College of Veterinary Medicine"
                    ]
    private var isRegisterReady: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        departmentPickerView.delegate = self
        navigationItem.largeTitleDisplayMode = .never
        pickerView(departmentPickerView, didSelectRow: 5, inComponent: 0)
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
              let majorInfo = departmentTextField.text else { return }
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
extension RegisterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        majorList.count
    }
    
    func pickerView(_: UIPickerView, titleForRow: Int, forComponent: Int) -> String? {
        return majorList[titleForRow]
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let department = majorList[row]
        departmentTextField.text = department
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if passwordTextField.text != reEnterTextField.text {
            reEnterTextField.backgroundColor = UIColor.red
        } else {
            reEnterTextField.backgroundColor = UIColor.green
        }
    }
}
