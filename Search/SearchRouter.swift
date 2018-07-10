//
//  SearchRouter.swift
//  UberChallenge
//
//  Created by Saalis Umer on 7/6/18.
//  Copyright © 2018 Saalis Umer. All rights reserved.
//

import UIKit
enum SearchResultDisplayRouterType : Int {
    case SearchResultType
}


class SearchRouter: Router {
    
    func showSearchResult(routeType : SearchResultDisplayRouterType){
        switch routeType {
        case .SearchResultType:
            let serchResultBuilder = SearchResultBuilder()
            let searchResultRiblet = serchResultBuilder.build(parentInteractor: self.riblet!.interactor)
            let context = Context(hashValue: routeType.rawValue)
            self.addChild(context: context, riblet: searchResultRiblet)
            if let childVC = searchResultRiblet.viewController {
                self.riblet?.viewController?.present(childVC, animated: true, completion: {
                })
            }
        }
    }
    
    func detachView(routeType : SearchResultDisplayRouterType) {
        switch routeType {
        case .SearchResultType:
            let context = Context(hashValue: routeType.rawValue)
            if let riblet = self.childRiblet(context: context) {
                riblet.viewController?.dismiss(animated: true, completion: {
                    self.removeChild(context: context)
                })
            }
        }
    }
    
    func interactorForContext(routeType : SearchResultDisplayRouterType) -> Interactor? {
        let context = Context(hashValue: routeType.rawValue)
        let riblet = self.childRiblet(context: context)
        return riblet?.interactor
    }
}
