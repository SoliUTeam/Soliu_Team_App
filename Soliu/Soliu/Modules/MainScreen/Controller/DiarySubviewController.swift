//
//  DiarySubviewController.swift
//  Soliu
//
//  Created by Yoonha Kim on 6/20/21.
//

import UIKit

protocol DiarySubviewDelegate: AnyObject {
    func submitDiary()
}

class DiarySubviewController: UIViewController {
    
    @IBOutlet private weak var moodImageView: UIImageView!
    @IBOutlet private weak var currentTimeDate: UILabel!
    @IBOutlet private weak var moodSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var noteTextfield: UITextField!
    
    private weak var delegate: DiarySubviewDelegate?
    lazy var diaryCellViewModel = DiarySubViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        currentTimeDate.text = date.getDateString(using: "MM-dd-yyyy HH:MM")
    }
    
    @IBAction private func saveButtonClicked() {
        diaryCellViewModel.getData(label: currentTimeDate, segmentedControl: moodSegmentedControl, noteField: noteTextfield)
        self.delegate?.submitDiary()
        self.dismiss(animated: true, completion: nil)
    }
}

