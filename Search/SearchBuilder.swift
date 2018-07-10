//
//  SearchBuilder.swift
//  UberChallenge
//
//  Created by Saalis Umer on 7/6/18.
//  Copyright © 2018 Saalis Umer. All rights reserved.
//

import UIKit

class SearchBuilder: Builder {    
    override func build() -> Riblet {
        
        let router = SearchRouter()

        let interactor = SearchInteractor()
        interactor.router = router

        let presenter = SearchPresenter()
        presenter.presenterOutput = interactor
        interactor.interactorOutput = presenter

        let vc = SearchViewController(nibName: "SearchViewController", bundle: Bundle.main)
        vc.presenter = presenter
        presenter.viewInput = vc
        
        let displayRiblet = Riblet(router: router, interactor: interactor,presenter: presenter)
        router.riblet = displayRiblet
        
        displayRiblet.viewController = vc

        return displayRiblet
    }
}
