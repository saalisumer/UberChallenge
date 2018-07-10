//
//  SearchResultPresenter.swift
//  UberChallenge
//
//  Created by Saalis Umer on 7/6/18.
//  Copyright © 2018 Saalis Umer. All rights reserved.
//

import UIKit
protocol SearchResultPresenterOutput:class {
     func didTapCloseSearchResult()
     func getPictures() -> [Picture]
     func fetchMorePictures()
}

class SearchResultPresenter:Presenter,SearchResultInteractorOutput,SearchResultViewOutput {
    weak var presenterOutput : SearchResultPresenterOutput?
    weak var viewInput : SearchResultViewInput?
    
    func didTapCloseSearchResult() {
        self.presenterOutput?.didTapCloseSearchResult()
    }
    
    func getPictures() -> [Picture] {
        if let pics = self.presenterOutput?.getPictures()
        {
            return pics
        }
        return []
    }
    
    func showSearchResult(pictures: [Picture], keyword:String) {
        self.viewInput?.showSearchResult(pictures: pictures, keyword: keyword)
    }
    
    func fetchMorePictures() {
        self.presenterOutput?.fetchMorePictures()
    }
    
    func showActivityIndicator(show: Bool) {
        self.viewInput?.showActivityIndicator(show: show)
    }
    
    func notifyNoMorePicsAvailable() {
        self.viewInput?.notifyNoMorePicsAvailable()
    }
}


