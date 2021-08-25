//
//  TestScreenViewController.swift
//  Soliu
//
//  Created by JungpyoHong on 8/24/21.
//

import Foundation
import UIKit


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
        
    }
}

extension TestScreenViewController: TestScreenViewModelDelegate {
    
    func reload() {
        self.tableView.reloadData()
    }
}
