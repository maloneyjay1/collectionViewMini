//
//  MovieListViewController.swift
//  MovieSearchCollectionViewMini
//
//  Created by Jordan Nelson on 11/7/15.
//  Copyright © 2015 Jordan Nelson. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController, UISearchResultsUpdating {

    @IBOutlet weak var tableView: UITableView!
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpSearchController()
        
//        MovieController.sharedInstance.searchForMovies("fargo") { (success) -> Void in
//            if success == true {
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    self.tableView.reloadData()
//                })
//            }
//        }
    }

    func setUpSearchController() {
        let resultsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("resultsViewController")
        
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search movie titles"
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.tableView.tableHeaderView?.reloadInputViews()
        }
        
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
    
        let lowercaseSearchTerm = searchController.searchBar.text!.lowercaseString
        
        MovieController.sharedInstance.searchForMovies(lowercaseSearchTerm) { (success) -> Void in
            if success == true {
               
                if let resultsController = searchController.searchResultsController as? ResultsViewController {
                  
                    resultsController.filteredMovies = MovieController.sharedInstance.movieArray.filter({$0.title.lowercaseString.containsString(lowercaseSearchTerm)})
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        resultsController.collectionView.reloadData()
                    })
                }
            }
        }
    }
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCellWithIdentifier("movieListCell", forIndexPath: indexPath) as! MovieListTableViewCell
        
        let movie = MovieController.sharedInstance.movieArray[indexPath.row]
        cell.titleLabel.text = movie.title
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieController.sharedInstance.movieArray.count
    }
    
    
}
















