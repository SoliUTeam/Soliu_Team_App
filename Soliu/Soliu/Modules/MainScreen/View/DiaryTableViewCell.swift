//
//  DiaryTableViewCell.swift
//  Soliu
//
//  Created by Yoonha Kim on 6/20/21.
//

import UIKit

class DiaryTableViewCell: UITableViewCell, CellReusable {
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var moodLabel: UILabel!
    @IBOutlet private weak var noteLabel: UILabel!
    @IBOutlet private weak var emotionImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(diary: DiaryTableViewCellViewModelProtocol) {
        self.dateLabel.text = diary.date
        self.moodLabel.text = diary.mood
        self.noteLabel.text = diary.note
    }
}
