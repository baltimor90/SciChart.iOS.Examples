//******************************************************************************
// SCICHART® Copyright SciChart Ltd. 2011-2019. All rights reserved.
//
// Web: http://www.scichart.com
// Support: support@scichart.com
// Sales:   sales@scichart.com
//
// PieChartView.m is part of the SCICHART® Examples. Permission is hereby granted
// to modify, create derivative works, distribute and publish any part of this source
// code whether for commercial, private or personal use.
//
// The SCICHART® examples are distributed in the hope that they will be useful, but
// without any warranty. It is provided "AS IS" without warranty of any kind, either
// expressed or implied.
//******************************************************************************

#import "PieChartView.h"

@implementation PieChartView

- (void)initExample {
    SCIPieRenderableSeries *pieSeries = [SCIPieRenderableSeries new];
    [pieSeries.segments add:[self buildSegmentWithValue:40.0 Title:@"Green" RadialGradient:[[SCIRadialGradientBrushStyle alloc] initWithCenterColorCode:0xff84BC3D edgeColorCode:0xff5B8829]]];
    [pieSeries.segments add:[self buildSegmentWithValue:10.0 Title:@"Red" RadialGradient:[[SCIRadialGradientBrushStyle alloc] initWithCenterColorCode:0xffe04a2f edgeColorCode:0xffB7161B]]];
    [pieSeries.segments add:[self buildSegmentWithValue:20.0 Title:@"Blue" RadialGradient:[[SCIRadialGradientBrushStyle alloc] initWithCenterColorCode:0xff4AB6C1 edgeColorCode:0xff2182AD]]];
    [pieSeries.segments add:[self buildSegmentWithValue:15.0 Title:@"Yellow" RadialGradient:[[SCIRadialGradientBrushStyle alloc] initWithCenterColorCode:0xffFFFF00 edgeColorCode:0xfffed325]]];
    
    // hiding the pie Renderable series - needed for animation
    // by default the pie renderable series are visible, so that when the animation starts - the pie chart might be already drawn
    pieSeries.isVisible = NO;
    
    SCIPieLegendModifier *legendModifier = [SCIPieLegendModifier new];
    legendModifier.sourceSeries = pieSeries;
    legendModifier.margins = UIEdgeInsetsMake(17, 17, 17, 17);
    legendModifier.position = SCIAlignment_Bottom | SCIAlignment_CenterHorizontal;
    
    SCIPieSelectionModifier *selectionModifier = [SCIPieSelectionModifier new];
    selectionModifier.selectionMode = SCIPieSelectionModifierSelectionMode_SingleSelectDeselectOnDoubleTap;
    
    [self.pieChartSurface.renderableSeries add:pieSeries];
    [self.pieChartSurface.chartModifiers add:legendModifier];
    [self.pieChartSurface.chartModifiers add:selectionModifier];
    
    dispatch_after(0, dispatch_get_main_queue(), ^(void){
        [pieSeries animate:0.7];
        pieSeries.isVisible = YES;
    });
}

- (SCIPieSegment *)buildSegmentWithValue:(double)segmentValue Title:(NSString *)title RadialGradient:(SCIRadialGradientBrushStyle *)gradientBrush {
    SCIPieSegment *segment = [SCIPieSegment new];
    segment.fillStyle = gradientBrush;
    segment.value = segmentValue;
    segment.title = title;
    
    return segment;
}

@end
