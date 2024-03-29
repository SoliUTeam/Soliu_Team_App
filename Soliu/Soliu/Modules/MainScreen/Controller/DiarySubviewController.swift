//
//  DiarySubviewController.swift
//  Soliu
//
//  Created by Yoonha Kim on 6/20/21.
//

import UIKit

protocol DiarySubviewDelegate: AnyObject {
    func reloadData()
}

class DiarySubviewController: UIViewController {
    
    @IBOutlet private weak var moodImageView: UIImageView!
    @IBOutlet private weak var currentTimeDate: UILabel!
    @IBOutlet private weak var moodSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var noteTextView: UITextView!
    
    lazy var diaryCellViewModel = DiarySubviewModel()
    weak var delegate: DiarySubviewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        noteTextView.delegate = self
        currentTimeDate.text = date.getDateString(using: "MMM d, yyyy")
        noteTextView.text = "Placeholder"
        noteTextView.textColor = UIColor.lightGray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction private func moodSegmentedControlChanged() {
        switch moodSegmentedControl.selectedSegmentIndex {
        case 0:
            moodImageView.image = UIImage(named: "Great")
        case 1:
            moodImageView.image = UIImage(named: "Good")
        case 2:
            moodImageView.image = UIImage(named: "Fair")
        case 3:
            moodImageView.image = UIImage(named: "Poor")
        case 4:
            moodImageView.image = UIImage(named: "Bad")

        default:
            print("It can't happen")
        }
        
    }
    @IBAction private func saveButtonClicked() {
        let date = Date()
        // Read noteData
        let name = ""
        let selectedMood = moodSegmentedControl.selectedSegmentIndex
        let note = noteTextView.text ?? ""
        diaryCellViewModel.saveDiaryData(name: name, mood: Int32(selectedMood), date: date.getDateString(using: "MMM d, yyyy"), note: note)
        self.delegate?.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
}

extension DiarySubviewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
    }
}

