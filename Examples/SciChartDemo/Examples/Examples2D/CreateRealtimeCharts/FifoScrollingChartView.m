//******************************************************************************
// SCICHART® Copyright SciChart Ltd. 2011-2019. All rights reserved.
//
// Web: http://www.scichart.com
// Support: support@scichart.com
// Sales:   sales@scichart.com
//
// FifoScrollingChartView.m is part of the SCICHART® Examples. Permission is hereby granted
// to modify, create derivative works, distribute and publish any part of this source
// code whether for commercial, private or personal use.
//
// The SCICHART® examples are distributed in the hope that they will be useful, but
// without any warranty. It is provided "AS IS" without warranty of any kind, either
// expressed or implied.
//******************************************************************************

#import "FifoScrollingChartView.h"
#import "SCDDataManager.h"
#import "SCDRandomUtil.h"

static int const FifoCapacicty = 50;
static double const TimeInterval = 30.0;
static double const OneOverTimeInterval = 1.0 / TimeInterval;
static double const VisibleRangeMax = FifoCapacicty * OneOverTimeInterval;
static double const GrowBy = VisibleRangeMax * 0.1;

@implementation FifoScrollingChartView {
    NSTimer *_timer;
    SCIXyDataSeries *_ds1;
    SCIXyDataSeries *_ds2;
    SCIXyDataSeries *_ds3;
    
    double _t;
    BOOL _isRunning;
}

- (void)commonInit {
    __weak typeof(self) wSelf = self;
    self.playCallback = ^() { _isRunning = YES; };
    self.pauseCallback = ^() { _isRunning = NO; };
    self.stopCallback = ^() {
        _isRunning = NO;
        [wSelf resetChart];
    };
}

- (void)initExample {
    id<ISCIAxis> xAxis = [SCINumericAxis new];
    xAxis.autoRange = SCIAutoRange_Never;
    xAxis.visibleRange = [[SCIDoubleRange alloc] initWithMin:-GrowBy max:VisibleRangeMax + GrowBy];
    
    id<ISCIAxis> yAxis = [SCINumericAxis new];
    yAxis.autoRange = SCIAutoRange_Always;
    
    _ds1 = [[SCIXyDataSeries alloc] initWithXType:SCIDataType_Double yType:SCIDataType_Double];
    _ds1.fifoCapacity = FifoCapacicty;
    _ds2 = [[SCIXyDataSeries alloc] initWithXType:SCIDataType_Double yType:SCIDataType_Double];
    _ds2.fifoCapacity = FifoCapacicty;
    _ds3 = [[SCIXyDataSeries alloc] initWithXType:SCIDataType_Double yType:SCIDataType_Double];
    _ds3.fifoCapacity = FifoCapacicty;

    SCIFastLineRenderableSeries *rs1 = [SCIFastLineRenderableSeries new];
    rs1.dataSeries = _ds1;
    rs1.strokeStyle = [[SCISolidPenStyle alloc] initWithColorCode:0xFF4083B7 thickness:2];
    
    SCIFastLineRenderableSeries *rs2 = [SCIFastLineRenderableSeries new];
    rs2.dataSeries = _ds2;
    rs2.strokeStyle = [[SCISolidPenStyle alloc] initWithColorCode:0xFFFFA500 thickness:2];
    
    SCIFastLineRenderableSeries *rs3 = [SCIFastLineRenderableSeries new];
    rs3.dataSeries = _ds3;
    rs3.strokeStyle = [[SCISolidPenStyle alloc] initWithColorCode:0xFFE13219 thickness:2];
    
    [SCIUpdateSuspender usingWithSuspendable:self.surface withBlock:^{
        [self.surface.xAxes add:xAxis];
        [self.surface.yAxes add:yAxis];
        [self.surface.renderableSeries add:rs1];
        [self.surface.renderableSeries add:rs2];
        [self.surface.renderableSeries add:rs3];
    }];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:TimeInterval / 1000.0 target:self selector:@selector(updateData:) userInfo:nil repeats:YES];
    _isRunning = YES;
}

- (void)updateData:(NSTimer *)timer {
    if (!_isRunning) return;
    
    double y1 = 3.0 * sin(((2 * M_PI) * 1.4) * _t) + [SCDRandomUtil nextDouble] * 0.5;
    double y2 = 2.0 * cos(((2 * M_PI) * 0.8) * _t) + [SCDRandomUtil nextDouble] * 0.5;
    double y3 = 1.0 * sin(((2 * M_PI) * 2.2) * _t) + [SCDRandomUtil nextDouble] * 0.5;
    
    [_ds1 appendX:@(_t) y:@(y1)];
    [_ds2 appendX:@(_t) y:@(y2)];
    [_ds3 appendX:@(_t) y:@(y3)];
    
    _t += OneOverTimeInterval;

    id<ISCIAxis> xAxis = [self.surface.xAxes itemAt:0];
    if (_t > VisibleRangeMax) {
        [xAxis.visibleRange setDoubleMinTo:xAxis.visibleRange.minAsDouble + OneOverTimeInterval maxTo:xAxis.visibleRange.maxAsDouble + OneOverTimeInterval];
    }
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow: newWindow];
    if (newWindow == nil) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)resetChart {
    [SCIUpdateSuspender usingWithSuspendable:self.surface withBlock:^{
        [_ds1 clear];
        [_ds2 clear];
        [_ds3 clear];
    }];
}

@end
