//******************************************************************************
// SCICHART® Copyright SciChart Ltd. 2011-2019. All rights reserved.
//
// Web: http://www.scichart.com
// Support: support@scichart.com
// Sales:   sales@scichart.com
//
// RolloverCustomizationChartView.m is part of the SCICHART® Examples. Permission is hereby granted
// to modify, create derivative works, distribute and publish any part of this source
// code whether for commercial, private or personal use.
//
// The SCICHART® examples are distributed in the hope that they will be useful, but
// without any warranty. It is provided "AS IS" without warranty of any kind, either
// expressed or implied.
//******************************************************************************

#import "RolloverCustomizationChartView.h"
#import "SCDDataManager.h"
#import "SCDRandomWalkGenerator.h"
#import <SciChart/SCIAxisTooltip+Protected.h>
#import <SciChart/SCIDefaultAxisInfoProvider+Protected.h>
#import <SciChart/SCISeriesTooltipBase+Protected.h>
#import <SciChart/SCISeriesInfoProviderBase+Protected.h>

#pragma mark - Cutsom Tooltips

@interface CustomRolloverAxisTooltip : SCIAxisTooltip
@end
@implementation CustomRolloverAxisTooltip
- (BOOL)updateInternalWithAxisInfo:(SCIAxisInfo *)axisInfo {
    self.text = [NSString stringWithFormat:@"Axis ID: %@\nValue: %@", axisInfo.axisId, axisInfo.axisFormattedDataValue.rawString];
    [self setTooltipBackground:0xff6495ed];
    return YES;
}
@end

@interface FirstCustomXySeriesTooltip : SCIXySeriesTooltip
@end
@implementation FirstCustomXySeriesTooltip
- (void)internalUpdateWithSeriesInfo:(SCIXySeriesInfo *)seriesInfo {
    NSString *string = NSString.Empty;
    string = [string stringByAppendingFormat:@"X: %@\n", seriesInfo.formattedXValue.rawString];
    string = [string stringByAppendingFormat:@"Y: %@\n", seriesInfo.formattedYValue.rawString];
    if (seriesInfo.seriesName != nil) {
        string = [string stringByAppendingFormat:@"%@\n", seriesInfo.seriesName];
    }
    string = [string stringByAppendingString:@"Rollover Modifier"];
    self.text = string;
    
    [self setTooltipBackground:0xffe2460c];
    [self setTooltipStroke:0xffff4500];
    [self setTooltipTextColor:0xffffffff];
}
@end

@interface SecondCustomXySeriesTooltip : SCIXySeriesTooltip
@end
@implementation SecondCustomXySeriesTooltip
- (void)internalUpdateWithSeriesInfo:(SCIXySeriesInfo *)seriesInfo {
    NSString *string = @"Rollover Modifier\n";
    if (seriesInfo.seriesName != nil) {
        string = [string stringByAppendingFormat:@"%@\n", seriesInfo.seriesName];
    }
    string = [string stringByAppendingFormat:@"X: %@ ", seriesInfo.formattedXValue.rawString];
    string = [string stringByAppendingFormat:@"Y: %@", seriesInfo.formattedYValue.rawString];
    self.text = string;
    
    [self setTooltipBackground:0xff6495ed];
    [self setTooltipStroke:0xff4d81dd];
    [self setTooltipTextColor:0xffffffff];
}
@end

#pragma mark - Cutsom Info Providers

@interface CustomRolloverAxisSeriesInfoProvider : SCIDefaultAxisInfoProvider
@end
@implementation CustomRolloverAxisSeriesInfoProvider
- (id<ISCIAxisTooltip>)getAxisTooltipInternal:(SCIAxisInfo *)axisInfo modifierType:(Class)modifierType {
    if (modifierType == SCIRolloverModifier.class) {
        return [[CustomRolloverAxisTooltip alloc] initWithAxisInfo:axisInfo];
    } else {
        return [super getAxisTooltipInternal:axisInfo modifierType:modifierType];
    }
}
@end

@interface FirstCustomRolloverSeriesInfoProvider : SCIDefaultXySeriesInfoProvider
@end
@implementation FirstCustomRolloverSeriesInfoProvider
- (id<ISCISeriesTooltip>)getSeriesTooltipInternalWithSeriesInfo:(SCIXySeriesInfo *)seriesInfo modifierType:(Class)modifierType {
    if (modifierType == SCIRolloverModifier.class) {
        return [[FirstCustomXySeriesTooltip alloc] initWithSeriesInfo:seriesInfo];
    } else {
        return [super getSeriesTooltipInternalWithSeriesInfo:seriesInfo modifierType:modifierType];
    }
}
@end
@interface SecondCustomRolloverSeriesInfoProvider : SCIDefaultXySeriesInfoProvider
@end
@implementation SecondCustomRolloverSeriesInfoProvider
- (id<ISCISeriesTooltip>)getSeriesTooltipInternalWithSeriesInfo:(SCIXySeriesInfo *)seriesInfo modifierType:(Class)modifierType {
    if (modifierType == SCIRolloverModifier.class) {
        return [[SecondCustomXySeriesTooltip alloc] initWithSeriesInfo:seriesInfo];
    } else {
        return [super getSeriesTooltipInternalWithSeriesInfo:seriesInfo modifierType:modifierType];
    }
}
@end

static int const PointsCount = 200;

#pragma mark - Chart Initialization

@implementation RolloverCustomizationChartView

- (void)initExample {
    id<ISCIAxis> xAxis = [SCINumericAxis new];
    xAxis.axisInfoProvider = [CustomRolloverAxisSeriesInfoProvider new];
    id<ISCIAxis> yAxis = [SCINumericAxis new];
    
    SCDRandomWalkGenerator *randomWalkGenerator = [SCDRandomWalkGenerator new];
    SCDDoubleSeries *data1 = [randomWalkGenerator getRandomWalkSeries:PointsCount];
    [randomWalkGenerator reset];
    SCDDoubleSeries *data2 = [randomWalkGenerator getRandomWalkSeries:PointsCount];
    
    SCIXyDataSeries *ds1 = [[SCIXyDataSeries alloc] initWithXType:SCIDataType_Double yType:SCIDataType_Double];
    ds1.seriesName = @"Series #1";
    SCIXyDataSeries *ds2 = [[SCIXyDataSeries alloc] initWithXType:SCIDataType_Double yType:SCIDataType_Double];
    ds2.seriesName = @"Series #2";
    
    [ds1 appendValuesX:data1.xValues y:data1.yValues];
    [ds2 appendValuesX:data2.xValues y:data2.yValues];
    
    SCIFastLineRenderableSeries *line1 = [SCIFastLineRenderableSeries new];
    line1.dataSeries = ds1;
    line1.strokeStyle = [[SCISolidPenStyle alloc] initWithColorCode:0xff6495ed thickness:2];
    line1.seriesInfoProvider = [FirstCustomRolloverSeriesInfoProvider new];
    
    SCIFastLineRenderableSeries *line2 = [SCIFastLineRenderableSeries new];
    line2.dataSeries = ds2;
    line2.strokeStyle = [[SCISolidPenStyle alloc] initWithColorCode:0xffe2460c thickness:2];
    line2.seriesInfoProvider = [SecondCustomRolloverSeriesInfoProvider new];
    
    [SCIUpdateSuspender usingWithSuspendable:self.surface withBlock:^{
        [self.surface.xAxes add:xAxis];
        [self.surface.yAxes add:yAxis];
        [self.surface.renderableSeries add:line1];
        [self.surface.renderableSeries add:line2];
        [self.surface.chartModifiers add:[SCIRolloverModifier new]];
        
        [SCIAnimations sweepSeries:line1 duration:3.0 andEasingFunction:[SCICubicEase new]];
        [SCIAnimations sweepSeries:line2 duration:3.0 andEasingFunction:[SCICubicEase new]];
    }];
}

@end
