//
//  TestResultViewController.swift
//  Soliu
//
//  Created by JungpyoHong on 9/29/21.
//

import Foundation
import UIKit

class TestResultViewController: UIViewController {
    
    @IBOutlet private weak var returnButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction private func gotoTestScreen(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let newTestScreen = storyboard.instantiateViewController(identifier: "NewStartTestScreenViewController") as? NewStartTestScreenViewController else {
            return
        }
        self.navigationController?.pushViewController(newTestScreen, animated: false)
    }
}
