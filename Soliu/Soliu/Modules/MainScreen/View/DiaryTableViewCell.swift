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
        self.noteLabel.text = diary.note
        
        switch diary.mood {
        case "0":
            emotionImageView.image = UIImage(named: "happy")
        case "1":
            emotionImageView.image = UIImage(named: "good")
        case "2":
            emotionImageView.image = UIImage(named: "meh")
        case "3":
            emotionImageView.image = UIImage(named: "bad")
        case "4":
            emotionImageView.image = UIImage(named: "awful")

        default:
            print("It can't happen")
    }
    }
}
