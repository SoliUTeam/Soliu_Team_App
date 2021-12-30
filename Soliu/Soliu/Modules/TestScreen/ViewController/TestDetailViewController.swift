//
//  TestDetailViewController.swift
//  Soliu
//
//  Created by JungpyoHong on 8/28/21.
//

import Foundation
import Firebase
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
    
    // Deprecated
    var questionDataSource: TestSection?
    var currentCount = 1
    lazy var viewModel = TestDetailViewModel()
    private var testScore: [Double] = []
    
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
        testScore.append(1.0)
        increaseProgress()
        uploadScore()
    }
    
    @IBAction private func touchAnswer2() {
        testScore.append(2.0)
        increaseProgress()
        uploadScore()
    }
    
    @IBAction private func touchAnswer3() {
        testScore.append(3.0)
        increaseProgress()
        uploadScore()
    }
    
    @IBAction private func touchAnswer4() {
        testScore.append(4.0)
        increaseProgress()
        uploadScore()
    }
    
    @IBAction private func touchAnswer5() {
        testScore.append(5.0)
        increaseProgress()
        uploadScore()
    }
    
    private func uploadScore() {
        if testScore.count == viewModel.getTotalQuestion() {
            viewModel.uploadData(testScore: testScore)
            testScore = []
        }
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
    
    private func loadingSpinner() {
        guard let loadingSpinner = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoadingSpinner") as? LoadingSpinner else { return }
        
        self.navigationController?.pushViewController(loadingSpinner, animated: false)
    }
}
