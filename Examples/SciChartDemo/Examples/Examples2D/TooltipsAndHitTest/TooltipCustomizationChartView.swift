//******************************************************************************
// SCICHART® Copyright SciChart Ltd. 2011-2019. All rights reserved.
//
// Web: http://www.scichart.com
// Support: support@scichart.com
// Sales:   sales@scichart.com
//
// TooltipCustomizationChartView.swift is part of the SCICHART® Examples. Permission is hereby granted
// to modify, create derivative works, distribute and publish any part of this source
// code whether for commercial, private or personal use.
//
// The SCICHART® examples are distributed in the hope that they will be useful, but
// without any warranty. It is provided "AS IS" without warranty of any kind, either
// expressed or implied.
//******************************************************************************

import SciChart.Protected.SCISeriesInfoProviderBase
import SciChart.Protected.SCISeriesTooltipBase

class TooltipCustomizationChartView: SingleChartLayout {
    
    private class FirstCustomSeriesInfoProvider: SCIDefaultXySeriesInfoProvider {
        class FirstCustomXySeriesTooltip: SCIXySeriesTooltip {
            override func internalUpdate(with seriesInfo: SCIXySeriesInfo!) {
                var string = NSString.empty;
                string += "X: \(seriesInfo.formattedXValue.rawString!)\n"
                string += "Y: \(seriesInfo.formattedXValue.rawString!)\n"
                if let seriesName = seriesInfo.seriesName {
                    string += "\(seriesName)\n"
                }
                string += "Tooltip Modifier"
                self.text = string;
                
                setTooltipBackground(0xffe2460c);
                setTooltipStroke(0xffff4500);
                setTooltipTextColor(0xffffffff);
            }
        }
        
        override func getSeriesTooltipInternal(seriesInfo: SCIXySeriesInfo!, modifierType: AnyClass!) -> ISCISeriesTooltip! {
            if (modifierType == SCITooltipModifier.self) {
                return FirstCustomXySeriesTooltip(seriesInfo: seriesInfo)
            } else {
                return super.getSeriesTooltipInternal(seriesInfo: seriesInfo, modifierType: modifierType)
            }
        }
    }
    
    private class SecondCustomSeriesInfoProvider: SCIDefaultXySeriesInfoProvider {
        class SecondCustomXySeriesTooltip: SCIXySeriesTooltip {
            override func internalUpdate(with seriesInfo: SCIXySeriesInfo!) {
                var string = "Tooltip Modifier\n";
                if let seriesName = seriesInfo.seriesName {
                    string += "\(seriesName)\n"
                }
                string += "X: \(seriesInfo.formattedXValue.rawString!) Y: \(seriesInfo.formattedXValue.rawString!)"
                self.text = string;
                
                setTooltipBackground(0xff6495ed);
                setTooltipStroke(0xff4d81dd);
                setTooltipTextColor(0xffffffff);
            }
        }
        
        override func getSeriesTooltipInternal(seriesInfo: SCIXySeriesInfo!, modifierType: AnyClass!) -> ISCISeriesTooltip! {
            if (modifierType == SCITooltipModifier.self) {
                return SecondCustomXySeriesTooltip(seriesInfo: seriesInfo)
            } else {
                return super.getSeriesTooltipInternal(seriesInfo: seriesInfo, modifierType: modifierType)
            }
        }
    }

    private let PointsCount = 200
    
    override func initExample() {
        let xAxis = SCINumericAxis()
        let yAxis = SCINumericAxis()
        
        let randomWalkGenerator = SCDRandomWalkGenerator()
        let data1 = randomWalkGenerator.getRandomWalkSeries(PointsCount)
        randomWalkGenerator.reset()
        let data2 = randomWalkGenerator.getRandomWalkSeries(PointsCount)
        
        let ds1 = SCIXyDataSeries(xType: .double, yType: .double)
        ds1.seriesName = "Series #1"
        let ds2 = SCIXyDataSeries(xType: .double, yType: .double)
        ds2.seriesName = "Series #2"
        
        ds1.append(x: data1.xValues, y: data1.yValues)
        ds2.append(x: data2.xValues, y: data2.yValues)
        
        let line1 = SCIFastLineRenderableSeries()
        line1.dataSeries = ds1
        line1.strokeStyle = SCISolidPenStyle(colorCode: 0xff6495ed, thickness: 2)
        line1.seriesInfoProvider = FirstCustomSeriesInfoProvider()
    
        let line2 = SCIFastLineRenderableSeries()
        line2.dataSeries = ds2
        line2.strokeStyle = SCISolidPenStyle(colorCode: 0xffe2460c, thickness: 2)
        line2.seriesInfoProvider = SecondCustomSeriesInfoProvider()
        
        SCIUpdateSuspender.usingWith(surface) {
            self.surface.xAxes.add(xAxis)
            self.surface.yAxes.add(yAxis)
            self.surface.renderableSeries.add(items: line1, line2)
            self.surface.chartModifiers.add(SCITooltipModifier())
            
            SCIAnimations.sweep(line1, duration: 3.0, easingFunction: SCICubicEase())
            SCIAnimations.sweep(line2, duration: 3.0, easingFunction: SCICubicEase())
        }
    }
}
