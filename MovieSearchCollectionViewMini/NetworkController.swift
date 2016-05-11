//
//  NetworkController.swift
//  MovieSearchCollectionViewMini
//
//  Created by Jordan Nelson on 11/7/15.
//  Copyright © 2015 Jordan Nelson. All rights reserved.
//

import Foundation

class NetworkController {
    
    static func baseURL(searchTerm:String) -> NSURL {
        let modifiedSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+")
        return NSURL(string: "http://api.themoviedb.org/3/search/movie?query=\(modifiedSearchTerm)&api_key=68a8779098e355ac704c413416c684af")!
    }
    
    
    static func dataAtURL(url:NSURL, completion:(resultData:NSData?) -> Void) {
        
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            
            dispatch_async(dispatch_get_main_queue()) {
                if let error = error {
                    print(error.localizedDescription)
                }
                completion(resultData: data)
            }
        }
        dataTask.resume()
    }
}









