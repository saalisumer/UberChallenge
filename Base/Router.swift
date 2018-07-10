//
//  Router.swift
//  Task
//
//  Created by Saalis Umer on 7/6/18.
//  Copyright © 2018 Saalis Umer. All rights reserved.
//

import Foundation
import UIKit

struct Context : Hashable, Equatable {
    
    var hashValue: Int
}

func ==(lhs: Context, rhs: Context) -> Bool {
    
    return lhs.hashValue == rhs.hashValue
}

class Router {
    
    weak var riblet : Riblet?
    var childRiblets : [Context : Riblet] = [:]

    func addChild(context : Context, riblet : Riblet) {
        
        self.childRiblets[context] = riblet
    }
    
    func removeChild(context : Context) {
        
        if (self.childRiblets[context] != nil) {
            
            self.childRiblets[context] = nil
        }
    }
    
    func childRiblet(context : Context) -> Riblet? {
        
        return self.childRiblets[context]
    }
    
    deinit {
//        print(type(of: self))
    }
    
}

