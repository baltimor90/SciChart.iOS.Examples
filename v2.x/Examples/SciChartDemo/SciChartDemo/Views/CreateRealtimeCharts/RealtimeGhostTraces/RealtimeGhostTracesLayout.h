//******************************************************************************
// SCICHART® Copyright SciChart Ltd. 2011-2018. All rights reserved.
//
// Web: http://www.scichart.com
// Support: support@scichart.com
// Sales:   sales@scichart.com
//
// RealtimeGhostTracesLayout.h is part of the SCICHART® Examples. Permission is hereby granted
// to modify, create derivative works, distribute and publish any part of this source
// code whether for commercial, private or personal use.
//
// The SCICHART® examples are distributed in the hope that they will be useful, but
// without any warranty. It is provided "AS IS" without warranty of any kind, either
// expressed or implied.
//******************************************************************************

#import <Foundation/Foundation.h>
#import <SciChart/SciChart.h>
#import "ExampleViewBase.h"

typedef void(^ActionWithSlider)(UISlider * sender);

@interface RealtimeGhostTracesLayout : ExampleViewBase

@property (nonatomic, copy) ActionWithSlider speedChanged;

@property (weak, nonatomic) IBOutlet UISlider * slider;
@property (weak, nonatomic) IBOutlet UILabel * millisecondsLabel;
@property (weak, nonatomic) IBOutlet SCIChartSurface * surface;

@end