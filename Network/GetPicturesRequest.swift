//
//  GetPicturesRequest.swift
//  UberChallenge
//
//  Created by Saalis Umer on 7/7/18.
//  Copyright © 2018 Saalis Umer. All rights reserved.
//

import Foundation
class GetPicturesRequest
{
    private let flickrURL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&format=json&nojsoncallback=1&safe_search=1&text="
    static var sharedSession:URLSession
    {
        get{
            let config:URLSessionConfiguration = URLSessionConfiguration.default
            return URLSession(configuration: config, delegate: nil, delegateQueue: OperationQueue())
        }
    }
    let keyword:String!
    init(keyword:String) {
        self.keyword = keyword
    }
    
    func fetchPictures(pageNumber:Int = 1, completion:@escaping (_ error:NSError?)->())
    {
        if let url = URL(string: (flickrURL+self.keyword+"&page=\(pageNumber)").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed
            .union(.urlHostAllowed)
            .union(.urlPasswordAllowed)
            .union(.urlQueryAllowed)
            .union(.urlUserAllowed))!)
        {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
    
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            let session = GetPicturesRequest.sharedSession
    
            let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
                if let networkError = error
                {
                    DispatchQueue.main.async {
                        completion(networkError as NSError)
                    }
                    return;
                }
                
                do
                {
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String,Any>
                    if let photos = json["photos"] as? Dictionary<String,Any>
                    {
                        let page = photos["page"] as? Int
                        let pages = photos["pages"] as? Int
                        let photoArray = photos["photo"] as? [Any]
                        var photosObj = [Picture]()
                        if let pageNo = page, let totalPages = pages, let photoArray = photoArray
                        {
                            for i in 0..<photoArray.count
                            {
                                if let pic = Picture(dict: photoArray[i] as? Dictionary<String,Any>)
                                {
                                    photosObj.append(pic)
                                }
                            }
                            
                            ApplicationModel.sharedInstance.addPictures(pictures: photosObj, keyword: self.keyword, pageNo: pageNo, totalPages: totalPages)
                        }
                    }
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
                catch
                {
                    DispatchQueue.main.async {
                        completion(NSError.jsonSerializationError())
                    }
                }
            })
    
            task.resume()
        }
        else
        {
            DispatchQueue.main.async {
                completion(nil)
            }
        }
    }
}
