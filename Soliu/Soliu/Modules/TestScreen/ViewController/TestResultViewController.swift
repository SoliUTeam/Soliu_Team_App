//
//  TestResultViewController.swift
//  Soliu
//
//  Created by JungpyoHong on 9/29/21.
//

import Foundation
import UIKit
import Charts

class TestResultViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet private weak var returnButton: UIButton!
    
    @IBOutlet weak var barChartView: BarChartView! {
        didSet {
            barChartView.backgroundColor = .clear
            barChartView.xAxis.labelPosition = .bottom
            barChartView.rightAxis.enabled = false
            barChartView.xAxis.drawGridLinesEnabled = false
            barChartView.xAxis.granularity = 1.0
            barChartView.xAxis.drawLabelsEnabled = false
            barChartView.legend.enabled = false
            barChartView.leftAxis.axisLineColor = .clear
            barChartView.xAxis.axisLineColor = .clear
            barChartView.xAxis.axisLineColor = .clear
            barChartView.drawBordersEnabled = false
            barChartView.animate(yAxisDuration: 2.0)
            barChartView.leftAxis.labelTextColor = .black
        }
    }
    
    var viewmode = TestResultViewModel()
    
    var tempLineChartEntry = [ChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction private func gotoTestScreen(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let newTestScreen = storyboard.instantiateViewController(identifier: "NewStartTestScreenViewController") as? NewStartTestScreenViewController else {
            return
        }
        self.navigationController?.pushViewController(newTestScreen, animated: false)
    }
    
    func setTempData() {
        let tempInputData = viewmode.setData(data: [5,3,7],
                                                          lineChartEntry: &tempLineChartEntry,
                                                          labelText: "Average Temperature",
                                                          mode: .cubicBezier,
                                                fillColor: .black)
        barChartView.data = tempInputData
    }
    
}
