//
//  MainControllerViewModel.swift
//  Soliu
//
//  Created by Yoonha Kim on 6/24/21.
//

import UIKit
import CoreData

class MainControllerViewModel {
    
    var container: NSPersistentContainer!
    var tableView: UITableView
    var dataSource: [Diary] = [] {
        didSet {
        self.tableView.reloadData()
        }
    }

    
    init(tableView: UITableView) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.tableView = tableView
        self.container = appDelegate.persistentContainer
    }
    
    func getAllItem() {
        do {
            guard let items = try container.viewContext.fetch(Diary.fetchRequest()) as? [Diary] else { return }
            dataSource = items

        }
        catch {
            print("Error")
        }
        dataSource.sort { date1, date2 in
            "".checkTheDate(firstDate: date1.date ?? "", secondDate: date2.date ?? "")
        }
    }
    
    
    func numberOfRowsInSection() -> Int {
        dataSource.count
    }
    
    func dataForDiary(at indexPath: Int) -> DiaryTableViewCellViewModelProtocol {
        DiaryTableViewCellViewModel(diary: dataSource[indexPath])
    }
}
