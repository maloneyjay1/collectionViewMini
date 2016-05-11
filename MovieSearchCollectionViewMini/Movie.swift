//
//  Movie.swift
//  MovieSearchCollectionViewMini
//
//  Created by Jordan Nelson on 11/7/15.
//  Copyright © 2015 Jordan Nelson. All rights reserved.
//

import Foundation

class Movie {
    
    let title: String
    let rating: Float
    let summary: String
    
    init(json:[String:AnyObject]) {
        guard let title = json["title"] as? String,
            let rating = json["vote_average"] as? Float,
            let summary = json["overview"] as? String else {
                self.title = ""
                self.summary = ""
                self.rating = 0
                return
        }
        self.title = title
        self.summary = summary
        self.rating = rating
    }
}












