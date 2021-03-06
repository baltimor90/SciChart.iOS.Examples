//******************************************************************************
// SCICHART® Copyright SciChart Ltd. 2011-2019. All rights reserved.
//
// Web: http://www.scichart.com
// Support: support@scichart.com
// Sales:   sales@scichart.com
//
// AnimationsSandboxLayout.h is part of the SCICHART® Examples. Permission is hereby granted
// to modify, create derivative works, distribute and publish any part of this source
// code whether for commercial, private or personal use.
//
// The SCICHART® examples are distributed in the hope that they will be useful, but
// without any warranty. It is provided "AS IS" without warranty of any kind, either
// expressed or implied.
//******************************************************************************

#import "ExampleViewBase.h"

@interface AnimationsSandboxLayout : ExampleViewBase

@property (weak, nonatomic) IBOutlet UITextField *selectSeriesTextField;
@property (weak, nonatomic) IBOutlet SCIChartSurface *surface;

@property (nonatomic) SCIAction scale;
@property (nonatomic) SCIAction wave;
@property (nonatomic) SCIAction sweep;
@property (nonatomic) SCIAction translateX;
@property (nonatomic) SCIAction translateY;

@end
