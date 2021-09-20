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
    @IBOutlet private weak var noteTextfield: UITextField!
    
    lazy var diaryCellViewModel = DiarySubviewModel()
    weak var delegate: DiarySubviewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        currentTimeDate.text = date.getDateString(using: "MM-dd HH:MM")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction private func moodSegmentedControlChanged() {
        switch moodSegmentedControl.selectedSegmentIndex {
        case 0:
            moodImageView.image = UIImage(named: "happy")
        case 1:
            moodImageView.image = UIImage(named: "good")
        case 2:
            moodImageView.image = UIImage(named: "meh")
        case 3:
            moodImageView.image = UIImage(named: "bad")
        case 4:
            moodImageView.image = UIImage(named: "awful")

        default:
            print("It can't happen")
        }
        
    }
    @IBAction private func saveButtonClicked() {
        let date = Date()
        // Read noteData
        let name = ""
        let currentTime = Date()
        let selectedMood = moodSegmentedControl.selectedSegmentIndex
        let note = noteTextfield.text ?? ""
        diaryCellViewModel.saveDiaryData(name: name, mood: selectedMood, date: date.getDateString(using: "MM-DD-yyy HH:MM"), note: note)
        self.delegate?.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
}

