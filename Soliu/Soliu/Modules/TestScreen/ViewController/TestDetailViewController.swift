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
        
        // set test number 1 as default
        viewModel.populateTestQuestionDataFromJson(number: 1)
        question.text = viewModel.getQuestionText()
        totalQuestion.text = viewModel.getTotalQuestion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
    
    func loadingSpinner() {
        //        if currentCount == viewModel.getTotalQuestion() {
        //
        //        }
//        self.performSegue(withIdentifier: "loadingSpinner", sender: nil)
        
        guard let loadingSpinner = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoadingSpinner") as? LoadingSpinner else { return }
        
        self.navigationController?.pushViewController(loadingSpinner, animated: false)
    }
}

extension TestDetailViewController: TestDetailViewControllable {
    func increaseProgress() {
        
        if currentCount != viewModel.getTotalQuestion() {
            currentCount += 1
            progressView.progress = viewModel.getProgress()
            viewModel.nextQuestion()
            question.text = viewModel.getQuestionText()
            currentQuestion.text = "\(currentCount)"
        } else {
            loadingSpinner()
        }
    }
}
