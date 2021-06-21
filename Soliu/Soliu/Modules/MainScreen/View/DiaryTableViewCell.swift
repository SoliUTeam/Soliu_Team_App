//
//  DiaryTableViewCell.swift
//  Soliu
//
//  Created by Yoonha Kim on 6/20/21.
//

import UIKit

class DiaryTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var moodLabel: UILabel!
    @IBOutlet private weak var noteLabel: UILabel!
    @IBOutlet private weak var emotionImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(diary: Diary) {
        self.dateLabel.text = diary.date
        self.moodLabel.text = diary.mood.rawValue
        self.noteLabel.text = diary.note
        
    }
    
}
