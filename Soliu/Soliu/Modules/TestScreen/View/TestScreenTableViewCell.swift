//
//  TestScreenTableViewCell.swift
//  Soliu
//
//  Created by JungpyoHong on 8/24/21.
//

import Foundation
import UIKit

class TestScreenTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var thumbImage: UIImageView!
    @IBOutlet private weak var title: UILabel!
    
    func configure(thumbImage: String, title: String, color: String) {
        self.thumbImage.image = UIImage(named: thumbImage)
        self.title.text = title
        self.backgroundColor = UIColor(hexaRGB: color)
    }
}
