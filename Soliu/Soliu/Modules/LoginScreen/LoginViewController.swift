import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField! {
        didSet {
            self.passwordTextField.isSecureTextEntry = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signIn() {
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
                    self.displayMessage(with: "Error", message: "\(error.localizedDescription)")
                }
            }
            else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    @IBAction private func openRegisterView() {
        self.performSegue(withIdentifier: "openRegisterView", sender: nil)
    }
    
    
}
