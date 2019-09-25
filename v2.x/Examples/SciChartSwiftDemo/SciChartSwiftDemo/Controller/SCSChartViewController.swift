//******************************************************************************
// SCICHART® Copyright SciChart Ltd. 2011-2018. All rights reserved.
//
// Web: http://www.scichart.com
// Support: support@scichart.com
// Sales:   sales@scichart.com
//
// SCSChartViewController.swift is part of the SCICHART® Examples. Permission is hereby granted
// to modify, create derivative works, distribute and publish any part of this source
// code whether for commercial, private or personal use.
//
// The SCICHART® examples are distributed in the hope that they will be useful, but
// without any warranty. It is provided "AS IS" without warranty of any kind, either
// expressed or implied.
//******************************************************************************

import UIKit
import SciChart

class SCSChartContainerController: UIViewController {
    
    var viewClass : UIView.Type?
    var chartVC : SCSChartViewController?
    var timer: Timer?
    
    func setupView(_ viewClass: UIView.Type) {
        self.viewClass = viewClass
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        if #available(iOS 10.0, *) {
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: {
                [weak self] (timer) in
                
                self?.chartVC?.willMove(toParentViewController: nil)
                self?.chartVC?.view.removeFromSuperview()
                self?.chartVC?.removeFromParentViewController()
                self?.addChartViewController()
            })
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
    }
    
     private func addChartViewController() {
        if chartVC == nil {
            chartVC = SCSChartViewController()
        }
        addChildViewController(chartVC!)
        
        view.addSubview(chartVC!.view)
        chartVC!.setupView(viewClass!)
        chartVC!.didMove(toParentViewController: self)
    }
}

class SCSChartViewController: UIViewController {
    
    func setupView(_ viewClass: UIView.Type) {
        let chartView = viewClass.init()
        addChartView(chartView)
    }
    
    private func addChartView(_ chartView: UIView) {
        chartView.frame.size = view.frame.size
        chartView.frame.origin = CGPoint()
        chartView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        chartView.translatesAutoresizingMaskIntoConstraints = true
        
        view.addSubview(chartView)
    }
}
