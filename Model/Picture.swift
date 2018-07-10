//
//  Picture.swift
//  UberChallenge
//
//  Created by Saalis Umer on 7/7/18.
//  Copyright © 2018 Saalis Umer. All rights reserved.
//

import UIKit
let flickrBaseURL = "http://farm{farm}.static.flickr.com/{server}/{id}_{secret}.jpg"
class Picture {
    let id:String!
    let owner:String?
    let secret:String!
    let server:String!
    let farm:Int!
    let title:String?
    let isPublic:Int?
    let isFriendly:Int?
    let isFamily:Int?
    var imageURL:String{
        get{
            return flickrBaseURL.replacingOccurrences(of: "{farm}", with: "\(self.farm!)").replacingOccurrences(of: "{server}", with: self.server).replacingOccurrences(of: "{id}", with: self.id).replacingOccurrences(of: "{secret}", with: self.secret)
        }
    }
    
    init?(dict:Dictionary<String, Any>?) {
        if let dict = dict {
            let id = dict["id"] as? String
            let owner = dict["owner"]  as? String
            let secret = dict["secret"]  as? String
            let server = dict["server"] as? String
            let farm = dict["farm"] as? Int
            let title = dict["title"]  as? String
            let isPublic = dict["isPublic"] as? Int
            let isFriendly = dict["isFriendly"] as? Int
            let isFamily = dict["isFamily"] as? Int
            guard farm != nil && server != nil && id != nil && secret != nil else {
                return nil
            }
            
            self.id = id!
            self.owner = owner
            self.secret = secret!
            self.server = server!
            self.farm = farm!
            self.title = title
            self.isPublic = isPublic
            self.isFriendly = isFriendly
            self.isFamily = isFamily
        }
        else
        {
            return nil
        }
    }
}
