//
//  TestResultViewModel.swift
//  Soliu
//
//  Created by JungpyoHong on 10/2/21.
//

import Foundation
import Charts

class TestResultViewModel {
    
    var chartAttribute = ReusableChartAttributeFunction()
    
    func setData (data: [Double], lineChartEntry: inout [ChartDataEntry], labelText: String, mode: LineChartDataSet.Mode, fillColor: UIColor) -> LineChartData {
                for index in 1...data.count {
                    let value = ChartDataEntry(x: Double(index), y: data[index - 1])
                    lineChartEntry.append(value)
                }

               let dataSet = LineChartDataSet(entries: lineChartEntry, label: labelText)
                chartAttribute.setLineChartDataAttribute(dataSet: dataSet,
                                                         mode: mode,
                                                         color: .black,
                                                         fillColor: fillColor.cgColor,
                                                         fillAlphaRate: 0.7,
                                                         lineColor: fillColor)
        let outputData = LineChartData(dataSet: dataSet)
        return outputData
    }
}

struct ReusableChartAttributeFunction {
    
    mutating func setLineChartAttribute(inputLineChart: LineChartView) {

        inputLineChart.backgroundColor = .clear
        inputLineChart.xAxis.labelPosition = .bottom
        inputLineChart.rightAxis.enabled = false
        inputLineChart.xAxis.drawGridLinesEnabled = false
        inputLineChart.xAxis.granularity = 1.0
        inputLineChart.xAxis.drawLabelsEnabled = false
        inputLineChart.legend.enabled = false
        inputLineChart.leftAxis.axisLineColor = .clear
        inputLineChart.xAxis.axisLineColor = .clear
        inputLineChart.xAxis.axisLineColor = .clear
        inputLineChart.drawBordersEnabled = false
        inputLineChart.animate(yAxisDuration: 2.0)
        inputLineChart.leftAxis.labelTextColor = .black
    }
    
    func setLineChartDataAttribute(dataSet: LineChartDataSet, mode: LineChartDataSet.Mode, color: UIColor, fillColor: CGColor, fillAlphaRate: CGFloat, lineColor: UIColor) {
        dataSet.mode = mode
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = true
        dataSet.lineWidth = 1
        dataSet.valueTextColor = color
        dataSet.fill = Fill(CGColor: fillColor)
        dataSet.fillAlpha = fillAlphaRate
        dataSet.drawFilledEnabled = true
        dataSet.setColor(lineColor)
    }
    
    func chartFormatter(inputData: LineChartData) {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        inputData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
    }
}
