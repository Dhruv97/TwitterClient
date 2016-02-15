//
//  TweetCell.swift
//  Twitter Client
//
//  Created by Dhruv Upadhyay on 2/15/16.
//  Copyright © 2016 Dhruv Upadhyay. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    var isRetweeted = false
    var isFavorited = false
    
    var id: Int!
    
    var tweet: Tweet?
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var twitterHandle: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var info: UILabel!
    
    @IBOutlet weak var retweetLabel: UILabel!
    
    @IBOutlet weak var favLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favButton: UIButton!
    
    
    @IBAction func retweetPressed(sender: AnyObject) {
        
        if isRetweeted == false {
            isRetweeted = true
            TwitterClient.sharedInstance.retweet(id!)
            let retweetNumber = Int(retweetLabel.text!)
            retweetLabel.text = String(retweetNumber! + 1)
            retweetButton.setImage(UIImage(named: "rt"), forState: .Normal)
            
        } else {
            isRetweeted = false
            TwitterClient.sharedInstance.untweet(id!)
            let retweetNumber = Int(retweetLabel.text!)
            retweetLabel.text = String(retweetNumber! - 1)
            retweetButton.setImage(UIImage(named: "unrt"), forState: .Normal)
        }
    }
    
    @IBAction func favPressed(sender: AnyObject) {
        
        if isFavorited == false {
            isFavorited = true
            TwitterClient.sharedInstance.favoriteTweet(id!)
            let favNumber = Int(favLabel.text!)
            favLabel.text = String(favNumber! + 1)
            favButton.setImage(UIImage(named: "fav"), forState: .Normal)
            
        } else {
            isFavorited = false
            TwitterClient.sharedInstance.unFavoriteTweet(id!)
            let favNumber = Int(favLabel.text!)
            favLabel.text = String(favNumber! - 1)
            favButton.setImage(UIImage(named: "unfav"), forState: .Normal)
        }
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImage.layer.cornerRadius = 5
        profileImage.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
