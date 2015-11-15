//
//  MoviesViewCell.swift
//  RottenTomato
//
//  Created by minh on 11/12/15.
//  Copyright © 2015 minh. All rights reserved.
//

import UIKit

class MoviesViewCell: UITableViewCell {
    
    @IBOutlet weak var photoMovie: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func loadData(movie: NSDictionary) {
        let imageURL = movie.valueForKeyPath("posters.thumbnail") as? String
        let title = movie.valueForKeyPath("title") as? String
        
        let rating = movie.valueForKeyPath("mpaa_rating")!
        let synopis = movie.valueForKeyPath("synopsis")!
        
        //        self.photoMovie.setImageWithURL(NSURL(string: imageURL!)!)
        let nsRequest = NSURLRequest(URL: NSURL(string: imageURL!)!)
        self.photoMovie.setImageWithURLRequest(nsRequest, placeholderImage: UIImage(named: "image default"), success: nil, failure: nil)
        self.photoMovie.layer.cornerRadius = 3
        self.photoMovie.clipsToBounds = true
        
        self.titleLabel.text = title
        self.descriptionLabel.attributedText = Tool.formatDescription(rating, synopis: synopis)
    }
}
