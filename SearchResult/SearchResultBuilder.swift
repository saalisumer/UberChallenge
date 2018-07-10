//
//  SearchResultBuilder.swift
//  UberChallenge
//
//  Created by Saalis Umer on 7/6/18.
//  Copyright © 2018 Saalis Umer. All rights reserved.
//

import UIKit

class SearchResultBuilder: Builder {
    override func build(parentInteractor : Interactor) -> Riblet {
        
        let router = SearchResultRouter()
        
        let interactor = SearchResultInteractor()
        interactor.router = router
        if let delegateInteractor = parentInteractor as? SearchResultInteractorDelegate
        {
            interactor.delegate = delegateInteractor
        }
        
        let presenter = SearchResultPresenter()
        presenter.presenterOutput = interactor
        interactor.interactorOutput = presenter
        
        let displayRiblet = Riblet(router: router, interactor: interactor, presenter:presenter)
        router.riblet = displayRiblet
        
        let vc = SearchResultViewController(nibName: "SearchResultViewController", bundle: Bundle.main)
        vc.presenter = presenter
        presenter.viewInput = vc
        displayRiblet.viewController = vc
        
        return displayRiblet
    }
}
