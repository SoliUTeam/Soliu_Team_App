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
    
    func configureTestCell(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell: TestScreenTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TestScreenTableViewCell") as? TestScreenTableViewCell
        else { fatalError("not find") }
        let test = testDataSource[indexPath.row]
        cell.configure(thumbImage: test.thumbImage, title: test.title)
        return cell
    }
}
