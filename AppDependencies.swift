//
//  AppDependencies.swift
//  Task
//
//  Created by Santosh Shanbhag on 15/1/17.
//  Copyright © 2017 Santosh Shanbhag. All rights reserved.
//

import Foundation
import UIKit

class AppDependencies {
    
    var rootRiblet : Riblet?
    var rootInteractor : RootInteractor?
    
    func configRootView(window : UIWindow, forLaunchOptions launchOptions:[UIApplicationLaunchOptionsKey: Any]? ) {
        let builder = SearchBuilder()
        let riblet = builder.build()
        self.rootRiblet = riblet
        
        if let rootInteractor = riblet.interactor as? RootInteractor {
            self.rootInteractor = rootInteractor
        }
        
        if let vc = riblet.viewController {
            window.rootViewController = vc
            window.makeKeyAndVisible()
        }
    }
}
