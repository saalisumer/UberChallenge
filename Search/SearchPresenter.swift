//
//  SearchPresenter.swift
//  UberChallenge
//
//  Created by Saalis Umer on 7/6/18.
//  Copyright © 2018 Saalis Umer. All rights reserved.
//

import UIKit

protocol SearchPresenterOutput:class {
    func didTapSearchWithKeyword(keyword: String?)
}


class SearchPresenter:Presenter,SearchInteractorOutput, SearchViewOutput {
    func showAlertWithError(error: NSError) {
        if let message = error.userInfo[MESSAGE_KEYWORD] as? String
        {
            self.viewInput?.showAlertWithMessage(message: message)
        }
        else
        {
            self.viewInput?.showAlertWithMessage(message: DEFAULT_ERROR_MESSAGE)
        }
    }
    
    func showActivityIndicator(show: Bool) {
        self.viewInput?.showActivityIndicator(show: show)
    }
    
    func didTapSearchWithKeyword(keyword: String?) {
        self.presenterOutput?.didTapSearchWithKeyword(keyword: keyword)
    }
    
    weak var presenterOutput : SearchPresenterOutput?
    weak var viewInput : SearchViewInput?
}
