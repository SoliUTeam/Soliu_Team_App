//
//  TestDetailViewController.swift
//  Soliu
//
//  Created by JungpyoHong on 8/28/21.
//

import Foundation
import UIKit

class TestDetailViewController: UIViewController {
    
    @IBOutlet private weak var question: UILabel!
    @IBOutlet private weak var answer1: UIButton!
    @IBOutlet private weak var answer2: UIButton!
    @IBOutlet private weak var answer3: UIButton!
    @IBOutlet private weak var answer4: UIButton!
    @IBOutlet private weak var answer5: UIButton!
    @IBOutlet private weak var progressView: UIProgressView!
    @IBOutlet private weak var currentQuestion: UILabel!
    @IBOutlet private weak var totalQuestion: UILabel!
    
    
    var questionDataSource: TestSection?
    var currentQuestionNumber = 1
    
    lazy var viewModel = TestDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestionNumber = 1
    }
    
    // upload data to firebase
    @IBAction private func touchAnswer1() {
        increaseProgress()
        viewModel.uploadData()
    }
    
    @IBAction private func touchAnswer2() {
        increaseProgress()
        viewModel.uploadData()
    }
    
    @IBAction private func touchAnswer3() {
        increaseProgress()
        viewModel.uploadData()
    }
    
    @IBAction private func touchAnswer4() {
        increaseProgress()
        viewModel.uploadData()
    }
    
    @IBAction private func touchAnswer5() {
        increaseProgress()
        viewModel.uploadData()
    }
    
    private func increaseProgress() {
        progressView.progress = Float(currentQuestionNumber / questionDataSource!.testNumber)
        currentQuestionNumber += 1
    }
    
}
