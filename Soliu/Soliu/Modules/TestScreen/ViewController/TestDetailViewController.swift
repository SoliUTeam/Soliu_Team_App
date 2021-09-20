//
//  TestDetailViewController.swift
//  Soliu
//
//  Created by JungpyoHong on 8/28/21.
//

import Foundation
import UIKit

protocol TestDetailViewControllable {
    func increaseProgress()
}

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
    var currentCount = 1
    lazy var viewModel = TestDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.populateTestQuestionDataFromJson(number: questionDataSource?.testNumber ?? 0)
        question.text = viewModel.getQuestionText()
        totalQuestion.text = viewModel.getTotalQuestion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //loadingSpinner()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.isNavigationBarHidden = true
//    }
    
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
        loadingSpinner()
    }
    
    func loadingSpinner() {
//        if currentCount == viewModel.getTotalQuestion() {
//
//        }
        self.performSegue(withIdentifier: "loadingSpinner", sender: nil)
    }
}

extension TestDetailViewController: TestDetailViewControllable {
    func increaseProgress() {
        currentCount += 1
        progressView.progress = viewModel.getProgress()
        viewModel.nextQuestion()
        question.text = viewModel.getQuestionText()
        currentQuestion.text = "\(currentCount)"
    }
}
