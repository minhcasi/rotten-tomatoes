//
//  MoviesDetailViewController.swift
//  RottenTomato
//
//  Created by minh on 11/12/15.
//  Copyright © 2015 minh. All rights reserved.
//

import UIKit

class MoviesDetailViewController: UIViewController {
    
    @IBOutlet weak var photoMovie: UIImageView!
    
    @IBOutlet weak var titleMovie: UILabel!
    
    @IBOutlet weak var labelPreview: UILabel!
    
    @IBOutlet weak var labelPG: UILabel!
    
    @IBOutlet weak var descriptionMovie: UITextView!
    
    @IBOutlet weak var detailView: UIView!
    
    
    var movie : NSDictionary!
    
    var isShowingFullView: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMovieDetail()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapView(sender: AnyObject) {
        updateViewWithAnimation();
    }
    
    func loadMovieDetail() {
        let imageURL = movie.valueForKeyPath("posters.detailed") as? String
        //        photoMovie.setImageWithURL(NSURL(string: imageURL!)!, placeholderImage: UIImage(named: "image default"))
        let nsRequest = NSURLRequest(URL: NSURL(string: imageURL!)!)
        photoMovie.setImageWithURLRequest(nsRequest, placeholderImage: UIImage(named: "image default"), success: nil, failure: nil)
        
        
        let title = movie["title"]!
        let year = movie["year"]!
        titleMovie.text = "\(title) (\(year))"
        
        self.title = title as? String
        
        let criticsScore = movie.valueForKeyPath("ratings.critics_score")!
        let audienceScore = movie.valueForKeyPath("ratings.audience_score")!
        labelPreview.text = "critics score \(criticsScore). Audience score \(audienceScore)"
        
        labelPG.text = movie.valueForKeyPath("mpaa_rating") as? String
        descriptionMovie.text = movie["synopsis"] as? String
        
        showSmallDetailView()
    }
    
    func showSmallDetailView() {
        var detailFrame: CGRect = detailView.frame
        detailFrame.origin.y = 300
        detailView.frame = detailFrame
        
        self.isShowingFullView = false
    }
    
    func showNoneDetailView() {
        var detailFrame: CGRect = detailView.frame
        detailFrame.origin.y = 1000
        detailView.frame = detailFrame
        
        self.isShowingFullView = true
    }
    
    func showFullDetailView() {
        var detailFrame: CGRect = detailView.frame
        detailFrame.origin.y = 64
        detailView.frame = detailFrame
        
        self.isShowingFullView = true
    }
    
    
    // animate the view
    func updateViewWithAnimation() {
        if self.isShowingFullView == true {
            UIView.animateWithDuration(0.3, delay: 0.3, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.showSmallDetailView()
                }, completion: nil)
        }
        else {
            UIView.animateWithDuration(0.3, delay: 0.3, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.showFullDetailView()
                }, completion: nil)
        }
    }
    
    @IBAction func tapToggleView(sender: AnyObject) {
        updateViewWithAnimation()
    }
    
    
    @IBAction func swipeDown(sender: AnyObject) {
        UIView.animateWithDuration(0.3, delay: 0.3, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.showNoneDetailView()
            }, completion: nil)
        
    }
    
    @IBAction func swipeUp(sender: AnyObject) {
        UIView.animateWithDuration(0.3, delay: 0.3, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.showSmallDetailView()
            }, completion: nil)
        
        
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    
    
}
