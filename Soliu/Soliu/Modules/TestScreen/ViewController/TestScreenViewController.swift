//
//  TestScreenViewController.swift
//  Soliu
//
//  Created by JungpyoHong on 8/24/21.
//

import Foundation
import Firebase
import UIKit


protocol TestScreenControllable {
    func isLoggedIn()
    func isLoggedIn(completionHandler: (Bool) -> ())
}

class TestScreenViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
    }
    
    lazy var viewModel = TestScreenViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.populateTestDataFromJson()
        //isLoggedIn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        // isLoggedIn()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
}

extension TestScreenViewController: TestScreenControllable {
    
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

extension TestScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.configureTestCell(in: tableView, for: indexPath)
    }
}

extension TestScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        isLoggedIn(completionHandler: { success in
//            if !success {
                viewModel.pushToDetail(viewController: self, index: indexPath.row)
//            }
//            else {
//                print("try register")
//            }
        })
        
    }
}

extension TestScreenViewController: TestScreenViewModelDelegate {
    
    func reload() {
        self.tableView.reloadData()
    }
}
