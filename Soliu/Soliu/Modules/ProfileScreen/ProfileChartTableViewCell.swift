//
//  ProfileChartTableViewCell.swift
//  Soliu
//
//  Created by Yoonha Kim on 9/20/21.
//

import UIKit
import Charts

class ProfileChartTableViewCell: UITableViewCell, CellReusable {
    
    @IBOutlet weak var charView: BarChartView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
