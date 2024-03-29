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
        isLoggedIn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        isLoggedIn()
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.dismiss(animated: animated, completion: nil)
        
    }
    
    @IBAction private func togoTest(_ sender: UIButton) {
//        if Auth.auth().currentUser == nil {
//            self.performSegue(withIdentifier: "testLoginScreen", sender: nil)
//        } else {
            guard let testDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TestDetailViewController") as? TestDetailViewController else { return }
            
            self.navigationController?.pushViewController(testDetailViewController, animated: false)
       // }
    }
}

extension NewStartTestScreenViewController: TestScreenControllable {
    
    func isLoggedIn() {
        if Auth.auth().currentUser == nil {
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
