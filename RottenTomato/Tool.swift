//
//  Tool.swift
//  RottenTomato
//
//  Created by minh on 11/12/15.
//  Copyright © 2015 minh. All rights reserved.
//

import Foundation
import UIKit

struct Tool {
    static func formatDescription(rating: AnyObject, synopis: AnyObject) ->  NSMutableAttributedString {
        let descMovie = "\(rating) - \(synopis)"
        
        let myMutableString = NSMutableAttributedString(string: descMovie, attributes: [NSFontAttributeName:UIFont(name: "Helvetica Neue", size: 12.0)!])
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: NSRange(location:0, length: rating.length + synopis.length))
        myMutableString.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFontOfSize(12), range: NSRange(location: 0, length: rating.length))
        

        return myMutableString;
    }
}