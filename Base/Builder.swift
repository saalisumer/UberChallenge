//
//  Builder.swift
//  Task
//
//  Created by Saalis Umer on 7/6/18.
//  Copyright © 2018 Saalis Umer. All rights reserved.
//

import Foundation

protocol BuilderProtocol {
    func build() -> Riblet
}

class Builder : BuilderProtocol  {
    func build() -> Riblet {
        abort()
    }
    
    func build(parentInteractor : Interactor) -> Riblet {
        abort()
    }
}
