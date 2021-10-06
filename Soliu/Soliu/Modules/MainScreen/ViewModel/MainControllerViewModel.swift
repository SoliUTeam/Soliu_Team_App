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
            print("Error all items")
        }
        dataSource.sort { date1, date2 in
            "".checkTheDate(firstDate: date1.date ?? "", secondDate: date2.date ?? "")
        }
        print(dataSource)
    }
    
    func deleteContext(at index: Int) {
        do {
            guard let items = try container.viewContext.fetch(Diary.fetchRequest()) as? [Diary] else { return }
            
            for item in items {
                if dataSource[index] == item {
                    container.viewContext.delete(item)
                }
            }
            try container.viewContext.save()
        }
        catch {
            print("Delete Errors")
        }
    }
    
    func numberOfRowsInSection() -> Int {
        dataSource.count
    }
    
    func dataForDiary(at indexPath: Int) -> DiaryTableViewCellViewModelProtocol {
        DiaryTableViewCellViewModel(diary: dataSource[indexPath])
    }
}
