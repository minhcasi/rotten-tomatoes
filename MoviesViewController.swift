//
//  MoviesViewController.swift
//  RottenTomato
//
//  Created by minh on 11/11/15.
//  Copyright © 2015 minh. All rights reserved.
//

import UIKit
import AFNetworking
import SwiftLoader
import ReachabilitySwift

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    var movies = [NSDictionary]()
    
    let sessions = NSUserDefaults.standardUserDefaults()
    
    let dataURL = "https://coderschool-movies.herokuapp.com/movies?api_key=xja087zcvxljadsflh214"
    
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl : UIRefreshControl!
    var reachability: Reachability!

    
    @IBOutlet weak var errorView: UIView!
    
    func hasConnection() -> Bool {
        let reachability: Reachability = try! Reachability.reachabilityForInternetConnection()
        let networkStatus: Int = reachability.currentReachabilityStatus.hashValue
        return networkStatus != 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        if Reachability.isReachable(<#T##Reachability#>) == true {
//            print("net work problem")
//        }
//        
        tableView.dataSource = self
        tableView.delegate = self
        
        // add refresh control
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        
        loadData()
    }

    
    func onRefresh() {
        loadMoviesList()
    }

    func loadData() {
        if self.hasConnection() {
            print("has connection")
            errorView.alpha = 0.0
            loadMoviesList()
        }
        else {
            print("no connection")
            loadMoviesListFromSession()
            UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.errorView.alpha = 1.0
            }, completion: nil)
        }
    }
    
    // get from the nsuserdata
    func loadMoviesListFromSession() {
        self.movies = sessions.objectForKey("movies") as! [NSDictionary]
        tableView.reloadData()
        
        // update movies position
        var movieFrame: CGRect = tableView.frame
        movieFrame.origin.y = 108
        tableView.frame = movieFrame
    }
    
    func loadMoviesList() {
        let url = NSURL(string: dataURL)
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        SwiftLoader.show(title: "Loading...", animated: true)
        
        // update movies position
        var movieFrame: CGRect = tableView.frame
        movieFrame.origin.y = 64
        tableView.frame = movieFrame
        
        let task = session.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
            
            // parse json to dictionary
            self.movies = json["movies"] as! [NSDictionary]
            
            // Save to NSUserDefaults
            self.sessions.setObject(self.movies, forKey: "movies")
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
                
                SwiftLoader.hide()
                
                self.refreshControl.endRefreshing()
            })
        }
        task.resume()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        return self.movies.count
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell    {
        let cell = tableView.dequeueReusableCellWithIdentifier("MoviesCell", forIndexPath:  indexPath) as! MoviesViewCell
        let movie = self.movies[indexPath.row]
        
        cell.loadData(movie)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    @IBAction func cancelClick(sender: AnyObject) {
        loadData()
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! MoviesViewCell
        let indexPath = tableView.indexPathForCell(cell)
        
        let movie = movies[indexPath!.row]
        
        let movieDetailController = segue.destinationViewController as? MoviesDetailViewController
        movieDetailController!.movie = movie
        
    }
}
