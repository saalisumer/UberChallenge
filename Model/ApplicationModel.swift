//
//  ApplicationModel.swift
//  UberChallenge
//
//  Created by Saalis Umer on 7/7/18.
//  Copyright © 2018 Saalis Umer. All rights reserved.
//

import Foundation
let PICTURE_RESULTS_CHANGED = "PICTURE_RESULTS_CHANGED"
class ApplicationModel
{
    static let sharedInstance:ApplicationModel = ApplicationModel()
    var keyword:String = ""
    var pageNo:Int = 0
    var totalPages:Int = 0
    private var pictures = [Picture]()
    private init() {
    }
    
    func clearSearchResult()
    {
        self.keyword = ""
        self.pictures.removeAll()
    }
    
    func addPictures(pictures:[Picture],keyword:String,pageNo:Int,totalPages:Int)
    {
        if (keyword != self.keyword)
        {
            self.clearSearchResult()
            self.keyword = keyword
            self.pageNo = 0
        }
        
        if pageNo <= self.pageNo {
            return;
        }
        
        self.totalPages = totalPages
        self.pageNo = pageNo
        
        if pictures.count > 0
        {
            self.pictures.append(contentsOf: pictures)
        }
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: PICTURE_RESULTS_CHANGED), object: nil)
        }
    }
    
    func getPictures()->[Picture]
    {
        return Array<Picture>(self.pictures)
    }
}
