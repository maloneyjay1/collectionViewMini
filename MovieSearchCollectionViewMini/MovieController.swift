//
//  MovieController.swift
//  MovieSearchCollectionViewMini
//
//  Created by Jordan Nelson on 11/7/15.
//  Copyright © 2015 Jordan Nelson. All rights reserved.
//

import Foundation

class MovieController {
    
   static let sharedInstance = MovieController()
    
    var movieArray:[Movie] = []
    
    func searchForMovies(searchTerm:String, completion:(success:Bool) -> Void){
        
        let url = NetworkController.baseURL(searchTerm)
        
        NetworkController.dataAtURL(url) { (resultData) -> Void in
            
            // Checking for ResultData
            guard let data = resultData else {
                print("No Data Returned")
                completion(success: false)
                return
            }
            
            do {
                let resultsAnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
                
                //parse json for correct results
                if let resultsDictionary = resultsAnyObject as? [String:AnyObject] {
                    if let resultsArray = resultsDictionary["results"] as? [[String:AnyObject]]
                    {
                        self.movieArray = []
                        // Cycle through movieArray, convert to movies
                        for movieDictionary in resultsArray {
                            let movie = Movie(json: movieDictionary)
                            self.movieArray.append(movie)
                        }
                        completion(success: true)
                    } else {
                        completion(success: false)
                    }
                }
            } catch {
                completion(success: false)
            }
        }
    }
}













