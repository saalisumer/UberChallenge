//
//  SearchInteractor.swift
//  UberChallenge
//
//  Created by Saalis Umer on 7/6/18.
//  Copyright © 2018 Saalis Umer. All rights reserved.
//

import UIKit

protocol SearchInteractorOutput:class {
    func showAlertWithError(error:NSError)
    func showActivityIndicator(show:Bool)
}

class SearchInteractor: Interactor, SearchPresenterOutput,SearchResultInteractorDelegate {
    func didTapSearchWithKeyword(keyword: String?) {
        if let text = keyword {
            let searchText = text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            if searchText.isAlphanumeric
            {
                if searchText.count <= 3
                {
                    self.interactorOutput?.showAlertWithError(error: NSError.keywordLengthLessThanThreeError())
                }
                else if searchText.count > 15
                {
                    self.interactorOutput?.showAlertWithError(error: NSError.keywordLengthGreaterThanFifteen())
                }
                else
                {
                    let request = GetPicturesRequest(keyword: searchText)
                    self.interactorOutput?.showActivityIndicator(show: true)
                    request.fetchPictures(completion: { (error) in
                        self.interactorOutput?.showActivityIndicator(show: false)
                        if let err = error
                        {
                            self.interactorOutput?.showAlertWithError(error: err)
                        }
                        else
                        {
                            if let currRouter = self.router as? SearchRouter
                            {
                                currRouter.showSearchResult(routeType: .SearchResultType)
                            }
                        }
                    })
                }
            }
            else
            {
                self.interactorOutput?.showAlertWithError(error: NSError.invalidKeywordError())
            }
        }
        else
        {
            self.interactorOutput?.showAlertWithError(error: NSError.invalidKeywordError())
        }
    }
    
    func didTapCloseSearchResult() {
        if let currRouter = self.router as? SearchRouter
        {
            currRouter.detachView(routeType: .SearchResultType)
        }
    }

    weak var interactorOutput : SearchInteractorOutput?
}
