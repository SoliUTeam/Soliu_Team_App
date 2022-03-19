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
    lazy var mainViewModel = MainControllerViewModel(delegate: self)
    
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var composeButton: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Your Emoji Diary"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        openDiarySubView()
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.openDiarySubView))
        composeButton.addGestureRecognizer(tapGR)
        composeButton.isUserInteractionEnabled = true
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
        else if segue.identifier == "openLoginViewController" {
            guard let destination = segue.destination as? LoginViewController else { return }
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
    
    @IBAction private func SignInOrOut() {
        if Auth.auth().currentUser == nil {
            self.performSegue(withIdentifier: "openLoginViewController", sender: nil)
        } else {
            SupportFirebase.supportFirebase.signOut()
        }
        setupUI()
    }
    
    @IBAction private func openDiarySubView() {
        self.performSegue(withIdentifier: "openDiarySubView", sender: nil)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiaryTableViewCell.reuseIdentifier) as? DiaryTableViewCell else { return UITableViewCell() }
        cell.configure(diary: mainViewModel.dataForDiary(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "\nDelete") {_,_,_ in
            guard self == self else { return }
            self.mainViewModel.deleteDiary(at: indexPath.row)
        }
        deleteAction.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension MainViewController: MainControllerViewModelProtocol {
    func reloadTableView() {
        self.tableView.reloadData()
    }
}

extension MainViewController: DiarySubviewDelegate {
    func reloadData() {
        mainViewModel.getAllItem()
        self.tableView.reloadData()
    }
}
