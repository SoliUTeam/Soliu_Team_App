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
    
    func populate() {
        let month = ["Jan", "Feb", "March"]
        let data = [20,30, 31]
        charView.noDataText = "데이터가 없습니다."
        charView.noDataFont = .systemFont(ofSize: 20)
        charView.noDataTextColor = .lightGray
        setChart(month: month, data: data)
    }
    
    func setChart(month: [String], data: [Int]) {
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<data.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(data[i]))
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Score")

        // 차트 컬러
        chartDataSet.colors = [.systemBlue]

        // 데이터 삽입
        let chartData = BarChartData(dataSet: chartDataSet)
        charView.data = chartData
    }
    
}
