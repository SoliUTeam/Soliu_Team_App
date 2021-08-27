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
    
    private var testDataSource = [TestSection]()
    
    func numberOfRow() -> Int {
        testDataSource.count
    }
    
    func populateDataFromJson() {
        if let path = Bundle.main.path(forResource: "testData", ofType: "json") {
            do {
                let dataJson = try Data(contentsOf: URL(fileURLWithPath: path))
                let jsonDict = try JSONSerialization.jsonObject(with: dataJson, options: .mutableContainers)
                if let jsonResults = jsonDict as? [String: Any],
                   let results = jsonResults["testData"] as? [[String: Any]] {
                    results.forEach { dict in
                        self.testDataSource.append(TestSection(thumbImage: dict["thumbImage"] as? String ?? "", title: dict["title"] as? String ?? "", color: dict["color"] as? String ?? ""))
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
}
