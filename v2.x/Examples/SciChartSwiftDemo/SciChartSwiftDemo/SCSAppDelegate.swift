//******************************************************************************
// SCICHART® Copyright SciChart Ltd. 2011-2018. All rights reserved.
//
// Web: http://www.scichart.com
// Support: support@scichart.com
// Sales:   sales@scichart.com
//
// SCSAppDelegate.swift is part of the SCICHART® Examples. Permission is hereby granted
// to modify, create derivative works, distribute and publish any part of this source
// code whether for commercial, private or personal use.
//
// The SCICHART® examples are distributed in the hope that they will be useful, but
// without any warranty. It is provided "AS IS" without warranty of any kind, either
// expressed or implied.
//******************************************************************************

import UIKit
import SciChart

@UIApplicationMain

class SCSAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //@BEGINDELETE
        let licensing = String.init(format:
            """
<LicenseContract>
<Customer>aleksey.moshkin@e-legion.com</Customer>
<OrderId>Trial</OrderId>
<LicenseCount>1</LicenseCount>
<IsTrialLicense>true</IsTrialLicense>
<SupportExpires>08/02/2019 00:00:00</SupportExpires>
<ProductCode>SC-IOS-2D-ENTERPRISE-SRC</ProductCode>
<KeyCode>6944e80ac03f96c7f46de2bf16259551788896e9316bd9891504f884c44fd40f947c58a242baa2b8f166d3d40344fcb1afd0af3a16ab8317f95098ac8cab6118af195f511467e48dd6f7e843ceddeab25d4bd416d3c8b12e136a0760807ebfb577afc86a70e51ed7ff2e2ceca4d6d414a5fc7bad7da8149300393ff371491e396f3019534c226334f4f125a36ab86e563913dc5dccbf9e2d6ac74e10d12c776d185f6b350d165c281597d5b860805d3c89bf</KeyCode>
</LicenseContract>
"""
        )
        SCIChartSurface.setRuntimeLicenseKey(licensing)
        //@ENDDELETE
        SCIChartSurface.setDisplayLinkRunLoopMode(.commonModes)
        return true
    }

}

