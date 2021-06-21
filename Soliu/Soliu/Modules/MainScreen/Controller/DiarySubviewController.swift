//
//  DiarySubviewController.swift
//  Soliu
//
//  Created by Yoonha Kim on 6/20/21.
//

import UIKit

protocol DiarySubviewDelegate: AnyObject {
    func submitDiary(_ diary: Diary)
}

class DiarySubviewController: UIViewController {
    
    @IBOutlet private weak var moodImageView: UIImageView!
    @IBOutlet private weak var currentTimeDate: UILabel!
    @IBOutlet private weak var moodSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var noteTextfield: UITextField!
    
    private weak var delegate: DiarySubviewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func saveButtonClicked() {
        var mood: Mood = Mood.good
        var date: String = ""
        var note: String = ""
        switch moodSegmentedControl.selectedSegmentIndex {
        case 0:
            mood = Mood.happy
        case 1:
            mood = Mood.good
        case 2:
            mood = Mood.meh
        case 3:
            mood = Mood.bad
        case 4:
            mood = Mood.awful
        default:
            print("segmentedControl")
        }
        
        note = noteTextfield.text ?? ""
        
        let diary = Diary(name: "", note: note, date: date.getCurrentDate(), mood: mood)
        self.delegate?.submitDiary(diary)
    }
    
}

