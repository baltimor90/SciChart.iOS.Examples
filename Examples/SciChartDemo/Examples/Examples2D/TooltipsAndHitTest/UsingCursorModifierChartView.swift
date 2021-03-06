//******************************************************************************
// SCICHART® Copyright SciChart Ltd. 2011-2019. All rights reserved.
//
// Web: http://www.scichart.com
// Support: support@scichart.com
// Sales:   sales@scichart.com
//
// UsingCursorModifierChartView.swift is part of the SCICHART® Examples. Permission is hereby granted
// to modify, create derivative works, distribute and publish any part of this source
// code whether for commercial, private or personal use.
//
// The SCICHART® examples are distributed in the hope that they will be useful, but
// without any warranty. It is provided "AS IS" without warranty of any kind, either
// expressed or implied.
//******************************************************************************

class UsingCursorModifierChartView: SingleChartLayout {
    
    let PointsCount = 500
    
    override func initExample() {
        let xAxis = SCINumericAxis();
        xAxis.visibleRange = SCIDoubleRange(min: 3, max: 6)
        
        let yAxis = SCINumericAxis();
        yAxis.growBy = SCIDoubleRange(min: 0.05, max: 0.05)
        yAxis.autoRange = .always
        
        let ds1 = SCIXyDataSeries(xType: .double, yType: .double)
        ds1.seriesName = "Green Series";
        let ds2 = SCIXyDataSeries(xType: .double, yType: .double)
        ds2.seriesName = "Red Series";
        let ds3 = SCIXyDataSeries(xType: .double, yType: .double)
        ds3.seriesName = "Gray Series";
        let ds4 = SCIXyDataSeries(xType: .double, yType: .double)
        ds4.seriesName = "Gold Series";
        
        let data1 = SCDDataManager.getNoisySinewave(withAmplitude: 300, phase: 1.0, pointCount: PointsCount, noiseAmplitude: 0.25)
        let data2 = SCDDataManager.getSinewaveWithAmplitude(100, phase: 2.0, pointCount: PointsCount)
        let data3 = SCDDataManager.getSinewaveWithAmplitude(200, phase: 1.5, pointCount: PointsCount)
        let data4 = SCDDataManager.getSinewaveWithAmplitude(50, phase: 0.1, pointCount: PointsCount)
        
        ds1.append(x: data1.xValues, y: data1.yValues)
        ds2.append(x: data2.xValues, y: data2.yValues)
        ds3.append(x: data3.xValues, y: data3.yValues)
        ds4.append(x: data4.xValues, y: data4.yValues)
        
        let rs1 = SCIFastLineRenderableSeries()
        rs1.dataSeries = ds1
        rs1.strokeStyle = SCISolidPenStyle(colorCode: 0xFF177B17, thickness: 2)
        
        let rs2 = SCIFastLineRenderableSeries()
        rs2.dataSeries = ds2
        rs2.strokeStyle = SCISolidPenStyle(colorCode: 0xFFDD0909, thickness: 2)
        
        let rs3 = SCIFastLineRenderableSeries()
        rs3.dataSeries = ds3
        rs3.strokeStyle = SCISolidPenStyle(colorCode: 0xFF808080, thickness: 2)
        
        let rs4 = SCIFastLineRenderableSeries()
        rs4.dataSeries = ds4
        rs4.strokeStyle = SCISolidPenStyle(colorCode: 0xFFFFD700, thickness: 2)
        rs4.isVisible = false

        SCIUpdateSuspender.usingWith(surface) {
            self.surface.xAxes.add(xAxis)
            self.surface.yAxes.add(yAxis)
            self.surface.renderableSeries.add(items: rs1, rs2, rs3, rs4)
            self.surface.chartModifiers.add(SCICursorModifier())
            
            SCIAnimations.sweep(rs1, duration: 3.0, easingFunction: SCICubicEase())
            SCIAnimations.sweep(rs2, duration: 3.0, easingFunction: SCICubicEase())
            SCIAnimations.sweep(rs3, duration: 3.0, easingFunction: SCICubicEase())
            SCIAnimations.sweep(rs4, duration: 3.0, easingFunction: SCICubicEase())
        }
    }
}
