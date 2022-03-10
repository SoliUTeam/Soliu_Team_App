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
        moodLabel.layer.cornerRadius = 18
    }
    
    func configure(diary: DiaryTableViewCellViewModelProtocol) {
        self.dateLabel.text = diary.date
        self.noteLabel.text = diary.note
        self.moodLabel.text = Mood(rawValue: diary.mood)?.text
                
        switch diary.mood {
        case 0:
            emotionImageView.image = UIImage(named: "Great")
//            moodLabel.backgroundColor = UIColor(red: 9, green: 172, blue: 86, alpha: 255)
            moodLabel.backgroundColor = UIColor.green
        case 1:
            emotionImageView.image = UIImage(named: "Good")
//            moodLabel.backgroundColor = UIColor(red: 125, green: 215, blue: 30, alpha: 255)
            moodLabel.backgroundColor = UIColor.systemGreen

        case 2:
            emotionImageView.image = UIImage(named: "Fair")
//            moodLabel.backgroundColor = UIColor(red: 258, green: 128, blue: 2, alpha: 255)
            moodLabel.backgroundColor = UIColor.yellow

        case 3:
            emotionImageView.image = UIImage(named: "Poor")
//            moodLabel.backgroundColor = UIColor(red: 253, green: 128, blue: 2, alpha: 255)
            moodLabel.backgroundColor = UIColor.orange

        case 4:
            emotionImageView.image = UIImage(named: "Bad")
//            moodLabel.backgroundColor = UIColor(red: 254, green: 12, blue: 14, alpha: 255)
            moodLabel.backgroundColor = UIColor.red

        default:
            print("It can't happen")
    }
    }
}
