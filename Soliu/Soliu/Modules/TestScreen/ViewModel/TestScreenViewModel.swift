//
//  TestScreenViewModel.swift
//  Soliu
//
//  Created by JungpyoHong on 8/24/21.
//

import Foundation
import UIKit

protocol TestScreenViewModelDelegate: AnyObject {
    func reload()
}

class TestScreenViewModel {
    
    init(delegate: TestScreenViewModelDelegate) {
        self.delegate = delegate
    }
    
    weak var delegate: TestScreenViewModelDelegate?
    
    // testDataSource : contain tableview cell information e.g color, thumb image
    private var testDataSource = [TestSection]()
    
    // testQuestion : contain test question data in testQuestion json file
    private var testQuestion = [TestQuestion]()
    
    func numberOfRow() -> Int {
        testDataSource.count
    }
    
    func populateTestDataFromJson() {
        if let path = Bundle.main.path(forResource: "testData", ofType: "json") {
            do {
                let dataJson = try Data(contentsOf: URL(fileURLWithPath: path))
                let jsonDict = try JSONSerialization.jsonObject(with: dataJson, options: .mutableContainers)
                if let jsonResults = jsonDict as? [String: Any],
                   let results = jsonResults["testData"] as? [[String: Any]] {
                    results.forEach { dict in
                        self.testDataSource.append(TestSection(thumbImage: dict["thumbImage"] as? String ?? "", title: dict["title"] as? String ?? "", color: dict["color"] as? String ?? "", testNumber: dict["testNumber"] as? Int ?? -1))
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    func configureTestCell(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell: TestScreenTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TestScreenTableViewCell") as? TestScreenTableViewCell
        else { fatalError("not find") }
        let test = testDataSource[indexPath.row]
        cell.configure(thumbImage: test.thumbImage, title: test.title, color: test.color)
        return cell
    }
    
    func pushToDetail(viewController: UIViewController, index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailTestScreen = storyboard.instantiateViewController(identifier: "TestDetailViewController") as? TestDetailViewController else {
            return
        }
        detailTestScreen.questionDataSource = testDataSource[index]
        viewController.navigationController?.pushViewController(detailTestScreen, animated: true)
    }
}
