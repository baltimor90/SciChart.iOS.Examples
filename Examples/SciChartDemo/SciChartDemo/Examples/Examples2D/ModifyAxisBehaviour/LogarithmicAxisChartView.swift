//******************************************************************************
// SCICHART® Copyright SciChart Ltd. 2011-2019. All rights reserved.
//
// Web: http://www.scichart.com
// Support: support@scichart.com
// Sales:   sales@scichart.com
//
// LogarithmicAxisChartView.swift is part of the SCICHART® Examples. Permission is hereby granted
// to modify, create derivative works, distribute and publish any part of this source
// code whether for commercial, private or personal use.
//
// The SCICHART® examples are distributed in the hope that they will be useful, but
// without any warranty. It is provided "AS IS" without warranty of any kind, either
// expressed or implied.
//******************************************************************************

class LogarithmicAxisChartView: SingleChartLayout {

    override func initExample() {
        let xAxis = SCILogarithmicNumericAxis()
        xAxis.growBy = SCIDoubleRange(min: 0.1, max: 0.1)
        xAxis.scientificNotation = .logarithmicBase
        xAxis.textFormatting = "#.#E+0"
        
        let yAxis = SCILogarithmicNumericAxis()
        yAxis.growBy = SCIDoubleRange(min: 0.1, max: 0.1)
        yAxis.scientificNotation = .logarithmicBase
        yAxis.textFormatting = "#.#E+0"

        let dataSeries1 = SCIXyDataSeries(xType: .double, yType: .double)
        dataSeries1.seriesName = "Curve A"
        let dataSeries2 = SCIXyDataSeries(xType: .double, yType: .double)
        dataSeries2.seriesName = "Curve B"
        let dataSeries3 = SCIXyDataSeries(xType: .double, yType: .double)
        dataSeries3.seriesName = "Curve C"

        let SCDDoubleSeries1 = SCDDataManager.getExponentialCurve(withExponent: 1.8, count: 100)
        let SCDDoubleSeries2 = SCDDataManager.getExponentialCurve(withExponent: 2.25, count: 100)
        let SCDDoubleSeries3 = SCDDataManager.getExponentialCurve(withExponent: 3.59, count: 100)
        
        dataSeries1.append(x: SCDDoubleSeries1.xValues, y: SCDDoubleSeries1.yValues)
        dataSeries2.append(x: SCDDoubleSeries2.xValues, y: SCDDoubleSeries2.yValues)
        dataSeries3.append(x: SCDDoubleSeries3.xValues, y: SCDDoubleSeries3.yValues)
        
        let line1Color: UInt32 = 0xFFFFFF00
        let line2Color: UInt32 = 0xFF279B27
        let line3Color: UInt32 = 0xFFFF1919
        
        let line1 = SCIFastLineRenderableSeries()
        line1.dataSeries = dataSeries1
        line1.strokeStyle = SCISolidPenStyle(colorCode: line1Color, thickness: 1.5)
        line1.pointMarker = getPointMarker(size: 5, colorCode: line1Color)

        let line2 = SCIFastLineRenderableSeries()
        line2.dataSeries = dataSeries2
        line2.strokeStyle = SCISolidPenStyle(colorCode: line2Color, thickness: 1.5)
        line2.pointMarker = getPointMarker(size: 5, colorCode: line2Color)
        
        let line3 = SCIFastLineRenderableSeries()
        line3.dataSeries = dataSeries3
        line3.strokeStyle = SCISolidPenStyle(colorCode: line3Color, thickness: 1.5)
        line3.pointMarker = getPointMarker(size: 5, colorCode: line3Color)
        
        SCIUpdateSuspender.usingWith(surface) {
            self.surface.xAxes.add(xAxis)
            self.surface.yAxes.add(yAxis)
            self.surface.renderableSeries.add(line1)
            self.surface.renderableSeries.add(line2)
            self.surface.renderableSeries.add(line3)
            self.surface.chartModifiers.add(ExampleViewBase.createDefaultModifiers())
            
            SCIAnimations.sweep(line1, duration: 3.0, easingFunction: SCICubicEase())
            SCIAnimations.sweep(line2, duration: 3.0, easingFunction: SCICubicEase())
            SCIAnimations.sweep(line3, duration: 3.0, easingFunction: SCICubicEase())
        }
    }

    fileprivate func getPointMarker(size: Int, colorCode: UInt32) -> SCIEllipsePointMarker {
        let pointMarker = SCIEllipsePointMarker()
        pointMarker.size = CGSize(width: CGFloat(size), height: CGFloat(size))
        pointMarker.strokeStyle = nil
        pointMarker.fillStyle = SCISolidBrushStyle(colorCode: colorCode)
        
        return pointMarker
    }
}
