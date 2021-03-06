//******************************************************************************
// SCICHART® Copyright SciChart Ltd. 2011-2019. All rights reserved.
//
// Web: http://www.scichart.com
// Support: support@scichart.com
// Sales:   sales@scichart.com
//
// UsingChartModifiers3DView.swift is part of the SCICHART® Examples. Permission is hereby granted
// to modify, create derivative works, distribute and publish any part of this source
// code whether for commercial, private or personal use.
//
// The SCICHART® examples are distributed in the hope that they will be useful, but
// without any warranty. It is provided "AS IS" without warranty of any kind, either
// expressed or implied.
//******************************************************************************

class UsingChartModifiers3DView: TopPanel3DChartLayout {
    
    let Count = 25
    
    override func commonInit() {
        let panel = TwoButtonsPanel()
        panel.leftButton?.setTitle("Rotate Horizontal", for: .normal)
        panel.rightButton?.setTitle("Rotate Vertical", for: .normal)
        panel.leftButton?.addTarget(self, action: #selector(UsingChartModifiers3DView.onRotateHorizontal), for: .touchUpInside)
        panel.rightButton?.addTarget(self, action: #selector(UsingChartModifiers3DView.onRotateVertical), for: .touchUpInside)
        
        self.panel = panel
    }
    
    override func initExample() {
        let xAxis = SCINumericAxis3D()
        xAxis.growBy = SCIDoubleRange(min: 0.1, max: 0.1)
        let yAxis = SCINumericAxis3D()
        yAxis.growBy = SCIDoubleRange(min: 0.1, max: 0.1)
        let zAxis = SCINumericAxis3D()
        zAxis.growBy = SCIDoubleRange(min: 0.1, max: 0.1)
        
        let ds = SCIXyzDataSeries3D(xType: .double, yType: .double, zType: .double)
        let metadataProvider = SCIPointMetadataProvider3D()
        
        for i in 0 ..< Count {
            let color = SCDDataManager.randomColor()
            for j in 1 ..< Count {
                let y = pow(Double(j), 0.3)
                ds.append(x: i, y: y, z: j)
                
                let metadata = SCIPointMetadata3D(vertexColor: color, andScale: 2.0)
                metadataProvider.metadata.add(metadata)
            }
        }
        
        let pointMarker = SCISpherePointMarker3D()
        pointMarker.size = 2.0
        
        let rs = SCIScatterRenderableSeries3D()
        rs.dataSeries = ds
        rs.pointMarker = pointMarker
        rs.metadataProvider = metadataProvider
        
        let zoomExtentsModifier = SCIZoomExtentsModifier3D()
        zoomExtentsModifier.animationDuration = 0.8
        zoomExtentsModifier.resetPosition = SCIVector3(x: 200.0, y: 200.0, z: 200.0);
        zoomExtentsModifier.resetTarget = SCIVector3(x: 0.0, y: 0.0, z: 0.0);
        
        SCIUpdateSuspender.usingWith(surface) {
            self.surface.xAxis = xAxis
            self.surface.yAxis = yAxis
            self.surface.zAxis = zAxis
            self.surface.renderableSeries.add(rs)
            self.surface.chartModifiers.add(items: SCIPinchZoomModifier3D(), SCIOrbitModifier3D(defaultNumberOfTouches: 1), SCIFreeLookModifier3D(defaultNumberOfTouches: 2), zoomExtentsModifier)
        }
    }
    
    @objc func onRotateHorizontal() {
        let camera: ISCICameraController? = surface.camera
        let orbitalYaw = camera?.orbitalYaw
        
        if (orbitalYaw ?? 0.0) < 360 {
            camera?.orbitalYaw = (orbitalYaw ?? 0.0) + 90
        } else {
            camera?.orbitalYaw = 360 - (orbitalYaw ?? 0.0)
        }
    }
    
    @objc func onRotateVertical() {
        let camera: ISCICameraController? = surface.camera
        let orbitalPitch = camera?.orbitalPitch
        
        if (orbitalPitch ?? 0.0) < 89 {
            camera?.orbitalPitch = (orbitalPitch ?? 0.0) + 90
        } else {
            camera?.orbitalPitch = -90
        }
    }
}
