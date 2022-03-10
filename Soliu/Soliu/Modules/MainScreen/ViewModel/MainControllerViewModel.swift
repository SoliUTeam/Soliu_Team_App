import UIKit
import CoreData

protocol MainControllerViewModelProtocol: AnyObject {
    func reloadTableView()
}

class MainControllerViewModel {
    
    var container: NSPersistentContainer!
    var dataSource: [Diary] = []
    weak var delegate: MainControllerViewModelProtocol?
    
    init(delegate: MainControllerViewModelProtocol) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        self.delegate = delegate
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
        delegate?.reloadTableView()
    }
    
    func deleteDiary(at index: Int) {
        do {
            guard let items = try container.viewContext.fetch(Diary.fetchRequest()) as? [Diary] else { return }
            
            for item in items {
                if dataSource[index] == item {
                    container.viewContext.delete(item)
                    dataSource.remove(at: index)
                }
            }
            try container.viewContext.save()
            
        }
        catch {
            print("Delete Errors")
        }
        delegate?.reloadTableView()
    }
    
    func numberOfRowsInSection() -> Int {
        dataSource.count
    }
    
    func dataForDiary(at indexPath: Int) -> DiaryTableViewCellViewModelProtocol {
        DiaryTableViewCellViewModel(diary: dataSource[indexPath])
    }
}
