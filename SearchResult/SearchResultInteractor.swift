//
//  SearchResultInteractor.swift
//  UberChallenge
//
//  Created by Saalis Umer on 7/6/18.
//  Copyright © 2018 Saalis Umer. All rights reserved.
//

import UIKit
protocol SearchResultInteractorOutput:class {
    func showSearchResult(pictures:[Picture],keyword:String)
    func showActivityIndicator(show:Bool)
    func notifyNoMorePicsAvailable()
}

protocol SearchResultInteractorDelegate:class {
    func didTapCloseSearchResult()
}

class SearchResultInteractor: Interactor,SearchResultPresenterOutput {
    weak var interactorOutput : SearchResultInteractorOutput?
    weak var delegate:SearchResultInteractorDelegate?
    var isFetchingMorePictures:Bool = false
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: NSNotification.Name(PICTURE_RESULTS_CHANGED), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func methodOfReceivedNotification(notification: Notification){
        self.interactorOutput?.showSearchResult(pictures: ApplicationModel.sharedInstance.getPictures(),keyword: ApplicationModel.sharedInstance.keyword)
    }
    
    func didTapCloseSearchResult() {
        self.delegate?.didTapCloseSearchResult()
    }
    
    func getPictures() -> [Picture] {
        return ApplicationModel.sharedInstance.getPictures()
    }
    
    func fetchMorePictures() {
        guard ApplicationModel.sharedInstance.pageNo < ApplicationModel.sharedInstance.totalPages else
        {
            self.interactorOutput?.notifyNoMorePicsAvailable()
            return
        }
        
        guard self.isFetchingMorePictures == false else
        {
            return
        }
        
        let request = GetPicturesRequest(keyword: ApplicationModel.sharedInstance.keyword)
        self.interactorOutput?.showActivityIndicator(show: true)
        self.isFetchingMorePictures = true
        request.fetchPictures(pageNumber:(ApplicationModel.sharedInstance.pageNo+1), completion: { (error) in
            self.isFetchingMorePictures = false
            self.interactorOutput?.showActivityIndicator(show: false)
            self.interactorOutput?.showSearchResult(pictures: ApplicationModel.sharedInstance.getPictures(),keyword: ApplicationModel.sharedInstance.keyword)
        })
    }
}
