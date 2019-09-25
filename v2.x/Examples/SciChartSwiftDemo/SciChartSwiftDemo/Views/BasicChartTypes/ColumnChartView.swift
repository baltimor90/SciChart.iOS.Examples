//******************************************************************************
// SCICHART® Copyright SciChart Ltd. 2011-2018. All rights reserved.
//
// Web: http://www.scichart.com
// Support: support@scichart.com
// Sales:   sales@scichart.com
//
// ColumnChartView.swift is part of the SCICHART® Examples. Permission is hereby granted
// to modify, create derivative works, distribute and publish any part of this source
// code whether for commercial, private or personal use.
//
// The SCICHART® examples are distributed in the hope that they will be useful, but
// without any warranty. It is provided "AS IS" without warranty of any kind, either
// expressed or implied.
//******************************************************************************


extension UIColor {
    
    static func color(red: Int, green: Int, blue: Int) -> UIColor {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        return UIColor.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    static func color(withHex rgb: Int) -> UIColor  {
        return UIColor.color(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    class var ad_green: UIColor {
        return UIColor.color(withHex: 0x5fa50d)
    }
    
    class var ad_mainBlack: UIColor {
        return UIColor.color(withHex: 0x0B1F35)
    }
    
    class var ad_mainBlack10: UIColor {
        return ad_mainBlack.withAlphaComponent(0.1)
    }
    
    class var ad_mainBlack15: UIColor {
        return ad_mainBlack.withAlphaComponent(0.15)
    }
    
    class var ad_mainBlack40: UIColor {
        return ad_mainBlack.withAlphaComponent(0.4)
    }
    
    class var ad_mainRed: UIColor {
        return UIColor.color(withHex: 0xF03226)
    }

    class var ad_drawRed: UIColor {
        return UIColor.color(withHex: 0xF03226)
    }
}

class ColumnsTripleColorPalette : SCIPaletteProvider {
    let style1 : SCIColumnSeriesStyle = SCIColumnSeriesStyle()
    let style2 : SCIColumnSeriesStyle = SCIColumnSeriesStyle()
    let style3 : SCIColumnSeriesStyle = SCIColumnSeriesStyle()
    
    override init() {
        super.init()
        
        style1.fillBrushStyle = SCISolidBrushStyle(color: UIColor.ad_mainBlack10)
        style1.strokeStyle = nil
        
        style2.fillBrushStyle = SCISolidBrushStyle(color: UIColor.ad_green.withAlphaComponent(0.3))
        style2.strokeStyle = nil
        
        style3.fillBrushStyle = SCISolidBrushStyle(color: UIColor.ad_mainRed.withAlphaComponent(0.3))
        style3.strokeStyle = nil
    }
    
    override func styleFor(x: Double, y: Double, index: Int32) -> SCIStyleProtocol! {
        let styleIndex : Int32 = index % 3;
        if (styleIndex == 0) {
            return style1;
        } else if (styleIndex == 1) {
            return style2;
        } else {
            return style3;
        }
    }
}



class ColumnChartView: SingleChartLayout {
    
    
    private let xAxisId = "chartxAxisId"
    private let yBarAxisId = "chartyBarAxisId"
    private let yCandleAxisId = "chartyCandleAxisId"
    
    private var gridLineThickness: Float = 1.5
    
    private lazy var majorGridLineStyle: SCISolidPenStyle = {
        let firstValue = gridLineThickness
        let secondValue = gridLineThickness + 0.1
        let values = [firstValue, secondValue, firstValue, secondValue]
        let pattern = values.map({ NSNumber(value: $0) })
        return SCISolidPenStyle(color: UIColor.ad_mainBlack15, withThickness: gridLineThickness, andStrokeDash: pattern)
    }()
    
    private lazy var mainAxisLineStyle: SCISolidPenStyle = {
        return SCISolidPenStyle(color: UIColor.ad_mainBlack40, withThickness: 1.0)
    }()
    
    private lazy var mainAxisXTextStyle: SCITextFormattingStyle = {
        let lineStyle = SCITextFormattingStyle()
        lineStyle.fontSize = 18
        lineStyle.color = UIColor.ad_mainBlack40
        
        return lineStyle
    }()
    
    private lazy var mainAxisYTextStyle: SCITextFormattingStyle = {
        let lineStyle = SCITextFormattingStyle()
        lineStyle.color = UIColor.ad_mainBlack40
        lineStyle.alignmentHorizontal = .left
        lineStyle.fontSize = 18
        return lineStyle
    }()
    
    override func initExample() {
        
//        surface.renderSurface = SCIMetalRenderSurface(frame: surface.bounds)
        
        surface.isOpaque = false
        surface.backgroundColor = UIColor.white
        surface.renderableSeriesAreaFill = SCISolidBrushStyle(color: UIColor.white)
        surface.renderableSeriesAreaBorder = SCISolidPenStyle(color: UIColor.white, withThickness: 0)
        surface.topAxisAreaForcedSize = 0
        surface.leftAxisAreaForcedSize = 0
        
        let xAxis = createAndConfigXAxis()
        
        let yAxis = createAndConfigYCandleAxis()
        
        let yAxis2 = createAndConfigYBarAxis()
        
        let dataSeries = SCIXyDataSeries(xType: .int32, yType: .int32)
        let yValues = [50, 35, 61, 58, 50, 50, 40, 53, 55, 23, 45, 12, 59, 60];
        for i in 0..<yValues.count {
            dataSeries.appendX(SCIGeneric(i), y: SCIGeneric(yValues[i]))
        }

        let rSeries = SCIFastColumnRenderableSeries()
        rSeries.xAxisId = xAxisId
        rSeries.yAxisId = yBarAxisId
        rSeries.dataSeries = dataSeries
        rSeries.paletteProvider = ColumnsTripleColorPalette()

        SCIUpdateSuspender.usingWithSuspendable(surface) {
            self.surface.xAxes.add(xAxis)
            self.surface.yAxes.add(yAxis)
            self.surface.yAxes.add(yAxis2)
            self.surface.renderableSeries.add(rSeries)
            self.addModifiers(surface: self.surface)
        }
        let drawLineAnnotation = createDrawLineAnnotation()
        surface.annotations.add(drawLineAnnotation)
        for i in 0..<10 {
            surface.annotations.add(createHorizontalAnnotation(y1: 0.5 + Double(i)))
        }
    }
    
    func createHorizontalAnnotation(y1: Double) -> SCILineAnnotation {
        let horizontalLine = SCIHorizontalLineAnnotation()
        horizontalLine.x1 = SCIGeneric(0)
        horizontalLine.y1 = SCIGeneric(y1)
        horizontalLine.horizontalAlignment = .right
        horizontalLine.xAxisId = xAxisId
        horizontalLine.yAxisId = yCandleAxisId
        
        let mainDashPattern: [NSNumber] = [1.1, 3.0, 1.1, 3.0]
        horizontalLine.style.linePen = SCISolidPenStyle(color: .black, withThickness: 1.0, andStrokeDash: mainDashPattern)
        let label = SCILineAnnotationLabel()
        label.text = " TEXT !"
        horizontalLine.add(label)
        return horizontalLine
    }
    
    func createDrawLineAnnotation() -> SCILineAnnotation {
        let annotation = SCILineAnnotation()
        let lineColor = UIColor.ad_drawRed
        annotation.style.linePen.color = lineColor
        annotation.style.resizeMarker.setPointMarkerColor(lineColor)
        annotation.x1 = SCIGeneric(0.2)
        annotation.y1 = SCIGeneric(0.2)
        annotation.x2 = SCIGeneric(3)
        annotation.y2 = SCIGeneric(3)
        annotation.xAxisId = xAxisId
        annotation.yAxisId = yCandleAxisId
        return annotation
    }
    
    func createAndConfigXAxis() -> SCINumericAxis {
        let xAxis = SCINumericAxis()
        xAxis.axisId = xAxisId
        xAxis.axisAlignment = .bottom
        xAxis.autoTicks = true
        xAxis.autoRange = .never
        xAxis.maxAutoTicks = 6
        
        let xAxisStyle = SCIAxisStyle()
        
        xAxisStyle.drawMajorTicks = true
        xAxisStyle.majorTickBrush = mainAxisLineStyle
        xAxisStyle.majorTickSize = 10
        
        xAxisStyle.drawMinorTicks = false
        
        xAxisStyle.drawMajorGridLines = false
        
        xAxisStyle.drawMinorGridLines = true
        xAxisStyle.minorGridLineBrush = majorGridLineStyle
        
        xAxisStyle.drawMajorBands = false
        
        xAxisStyle.drawLabels = true
        xAxisStyle.labelStyle = mainAxisXTextStyle
        
        xAxis.style = xAxisStyle
        
//        chartDecorationProvider.subscribeForChangingGraphSettings(with: xAxis)
        
        return xAxis
    }
    
    func createAndConfigYCandleAxis() -> SCINumericAxis {
        let yCandleAxis = SCINumericAxis()
        yCandleAxis.axisId = yCandleAxisId
        yCandleAxis.axisAlignment = .right
        yCandleAxis.autoTicks = true
        yCandleAxis.autoRange = .always
        yCandleAxis.maxAutoTicks = 10
        yCandleAxis.growBy = SCIDoubleRange(min: SCIGeneric(0.3), max: SCIGeneric(0.2))
        
        let yCandleAxisStyle = SCIAxisStyle()
        
        yCandleAxisStyle.labelSpacing = 0
        
        yCandleAxisStyle.drawMajorTicks = false
        yCandleAxisStyle.drawMinorTicks = false
        
        yCandleAxisStyle.drawMajorGridLines = false
        yCandleAxisStyle.drawMinorGridLines = false
        
        yCandleAxisStyle.drawMajorBands = false
        
        yCandleAxisStyle.drawLabels = true
        yCandleAxisStyle.labelStyle = mainAxisYTextStyle
        
        yCandleAxis.style = yCandleAxisStyle
        
        return yCandleAxis
    }
    
    func createAndConfigYBarAxis() -> SCINumericAxis {
        let yBarAxis = SCINumericAxis()
        yBarAxis.axisId = yBarAxisId
        yBarAxis.axisAlignment = .right
        yBarAxis.autoTicks = true
        yBarAxis.autoRange = .always
        yBarAxis.isVisible = false
        yBarAxis.growBy = SCIDoubleRange(min: SCIGeneric(0.0), max: SCIGeneric(4.0))
        yBarAxis.style.labelSpacing = 0
        
        return yBarAxis
    }
    
    private func addModifiers(surface: SCIChartSurface) {
        let axisLineModifier = DrawOnAxisModifier(for: [xAxisId, yCandleAxisId], with: mainAxisLineStyle)
        let modifierCollection = SCIChartModifierCollection(childModifiers: [axisLineModifier])
        
        surface.chartModifiers = modifierCollection
    }
}



class DrawOnAxisModifier: SCIChartModifierBase {
    
    // MARK: - Private properties
    
    private let lineStyle: SCIPenStyleProtocol
    private let axisIDs: [String]
    
    // MARK: - Life cycle
    
    init(for axisIDs: [String], with lineStyle: SCIPenStyleProtocol) {
        self.axisIDs = axisIDs
        self.lineStyle = lineStyle
    }
    
    override func draw() {
        super.draw()
        
        guard let renderContext = parentSurface.renderSurface?.modifierContext() else { return }
        
        renderContext.save()
        
        for axisId in axisIDs {
            var axis: SCIAxis2DProtocol?
            
            if let xAxes = parentSurface.xAxes.getAxisById(axisId) {
                axis = xAxes
            }
            if let yAxes = parentSurface.yAxes.getAxisById(axisId) {
                axis = yAxes
            }
            
            guard let renderAxis = axis else { continue }
            
            
            
            let points = getDrawLineCoordinate(for: renderAxis)
            let axisFrame = renderAxis.frame()
            let area: CGRect = parentSurface.chartFrame()
            renderContext.setDrawingArea(area)
            let pen = renderContext.createPen(fromStyle: lineStyle)
            renderContext.drawLine(withBrush: pen,
                                   fromX: Float(points.start.x+axisFrame.origin.x),
                                   y: Float(points.start.y+axisFrame.origin.y),
                                   toX: Float(points.end.x+axisFrame.origin.x),
                                   y: Float(points.end.y+axisFrame.origin.y))
            
            
        }
        
        renderContext.restore()
    }
    
    // MARK: - Private
    
    private func getDrawLineCoordinate(for axis: SCIAxis2DProtocol) -> (start: CGPoint, end: CGPoint) {
        var start: CGPoint
        var end: CGPoint
        let frame = axis.frame()
        
        switch axis.axisAlignment {
        case .top:
            start = CGPoint(x: 0, y: frame.size.height)
            end = CGPoint(x: frame.size.width, y: frame.size.height)
        case .bottom:
            start = CGPoint(x: 0, y: 0)
            end = CGPoint(x: frame.size.width, y: 0)
        case .right:
            start = CGPoint(x: 0, y: 0)
            end = CGPoint(x: 0, y: frame.size.height)
        case .left:
            start = CGPoint(x: frame.size.width, y: 0)
            end = CGPoint(x: frame.size.width, y: frame.size.height)
        default:
            fatalError("Unreachable")
        }
        
        return (start, end)
    }
}
