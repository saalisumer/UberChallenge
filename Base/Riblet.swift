//
//  Riblet.swift
//  Task
//
//  Created by Saalis Umer on 7/6/18.
//  Copyright © 2018 Saalis Umer. All rights reserved.
//

import Foundation
import UIKit

class Riblet : Equatable {
    
    var router : Router
    var interactor : Interactor
    var presenter : Presenter?
    var viewController : UIViewController?
        
    init(router : Router, interactor : Interactor, presenter: Presenter?) {
        
        self.router = router
        self.interactor = interactor
        if let currPresenter = presenter {
            self.presenter = currPresenter
        }
    }

    deinit {
//        print(type(of: self))
    }
}

func ==(lhs: Riblet, rhs: Riblet) -> Bool {
    
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}


