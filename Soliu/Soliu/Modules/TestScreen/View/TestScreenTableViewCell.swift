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
    
    func configure(thumbImage: UIImage, title: UILabel) {
        self.thumbImage.image = thumbImage
        self.title = title
    }
}
