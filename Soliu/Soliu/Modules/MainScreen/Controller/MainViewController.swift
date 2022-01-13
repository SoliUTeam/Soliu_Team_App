//
//  ViewController.swift
//  Soliu
//
//  Created by Yoonha Kim on 6/18/21.
//

import UIKit
import CoreData
import Firebase

class MainViewController: UIViewController {
    
    // Container for CoreData parts
    var container: NSPersistentContainer!
    lazy var mainViewModel = MainControllerViewModel(tableView: tableView)
    
    @IBOutlet var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Your Emoji Diary"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        openDiarySubView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mainViewModel.getAllItem()
        setupUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openDiarySubView" {
            guard let destination = segue.destination as? DiarySubviewController else { return }
            destination.delegate = self
        }
    }
    
    private func setupUI() {
        if Auth.auth().currentUser == nil {
            signInButton.setTitle("Sign In", for: .normal)
        } else {
            signInButton.setTitle("Sign Out", for: .normal)
        }
    }
    
    // TableView for emotion diary
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.register(UINib(nibName: DiaryTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: DiaryTableViewCell.reuseIdentifier)
            self.tableView.register(UINib(nibName: DiaryTableFooterView.reuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: DiaryTableFooterView.reuseIdentifier)
        }
    }
    
    @IBAction private func signOut() {
        SupportFirebase.supportFirebase.signOut()
        setupUI()
    }
    
    func openDiarySubView() {
        self.performSegue(withIdentifier: "openDiarySubView", sender: nil)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiaryTableViewCell.reuseIdentifier) as? DiaryTableViewCell else { return UITableViewCell()}
        cell.configure(diary: mainViewModel.dataForDiary(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            mainViewModel.deleteContext(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: DiaryTableFooterView.reuseIdentifier) else { return UIView() }
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
}

extension MainViewController: DiarySubviewDelegate {
    func reloadData() {
        mainViewModel.getAllItem()
        self.tableView.reloadData()
    }
}
