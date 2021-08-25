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
        currentTimeDate.text = date.getDateString(using: "MM-dd-yyyy HH:MM")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction private func saveButtonClicked() {
        // Read noteData
        let name = ""
        let currentTime = currentTimeDate.text ?? ""
        let selectedMood = moodSegmentedControl.selectedSegmentIndex
        let note = noteTextfield.text ?? ""
        diaryCellViewModel.saveDiaryData(name: name, mood: selectedMood, date: currentTime, note: note)
        self.delegate?.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
}

