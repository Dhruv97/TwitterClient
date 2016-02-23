//
//  DetailViewController.swift
//  Twitter Client
//
//  Created by Dhruv Upadhyay on 2/16/16.
//  Copyright © 2016 Dhruv Upadhyay. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
   
    
    var tweet: Tweet!
    
    var isRetweeted = false
    var isFavorited = false

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var favButton: UIButton!
    
    @IBOutlet weak var rtButton: UIButton!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var handle: UILabel!
    
    @IBOutlet weak var info: UILabel!
    
    @IBOutlet weak var rtLabel: UILabel!

    @IBOutlet weak var favLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
            name.text = tweet.user?.name
            handle.text = "@\((tweet.user?.screenname)!)"
            info.text = tweet.text
        
            rtLabel.text = "\(tweet.retweetCount)"
            favLabel.text = "\(tweet.favoriteCount)"
        
            profileImage.layer.cornerRadius = 5
            profileImage.clipsToBounds = true
        
            if let imageURL = tweet.user?.profileImageURL {
            profileImage.setImageWithURL(NSURL(string: imageURL)!)
        }
        
        
        rtLabel.text = String(tweet.retweetCount)
        favLabel.text = String(tweet.favoriteCount)
        
        let time = Int((tweet?.createdAt?.timeIntervalSinceNow)!)
        
        if time/3600 == 0 {
            timeLabel.text = "\(-time/60)m"
        } else if time/86400 == 0 {
            timeLabel.text = "\(-time/3600)h"
        } else if time/604800 == 0 {
            timeLabel.text = "\(-time/86400)d"
        }
        
        if tweet!.isRetweeted! {
            rtButton.setImage(UIImage(named: "retweet-action-on"), forState: .Normal)
           
            rtButton.setImage(UIImage(named: "rt"), forState: .Normal)
            rtLabel.text = "\(tweet!.retweetCount!)"
        } else {
            rtButton.setImage(UIImage(named: "unrt"), forState: .Normal)
            rtLabel.text = "\(tweet!.retweetCount!)"
        }
        
        if  tweet!.isFavorited! {
            favButton.setImage(UIImage(named: "fav"), forState: .Normal)
           
            favLabel.text = "\(tweet!.favoriteCount!)"
        } else {
            favButton.setImage(UIImage(named: "unfav"), forState: .Normal)
           
            favLabel.text = "\(tweet!.favoriteCount!)"
        }
        
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func rtPressed(sender: AnyObject) {
        if tweet.isRetweeted == false {
            TwitterClient.sharedInstance.retweet((tweet?.id)!)
            rtButton.setImage(UIImage(named: "rt"), forState: .Normal)
            rtLabel.text = "\(tweet.retweetCount + 1)"
        } else {
            TwitterClient.sharedInstance.untweet((tweet?.id)!)
            rtButton.setImage(UIImage(named: "unrt"), forState: .Normal)
            rtLabel.text = "\(tweet.retweetCount)"
        }
        
        tweet.isRetweeted = !tweet.isRetweeted
    }
    

    @IBAction func favPressed(sender: AnyObject) {
        
        if tweet.isFavorited == false {
            TwitterClient.sharedInstance.favoriteTweet(tweet.id!)
            favButton.setImage(UIImage(named: "fav"), forState: .Normal)
            favLabel.text = "\(tweet.favoriteCount + 1)"
        } else {
            TwitterClient.sharedInstance.unFavoriteTweet((tweet?.id)!)
            favButton.setImage(UIImage(named: "unfav"), forState: .Normal)
            favLabel.text = "\(tweet.favoriteCount)"
        }
        
        tweet.isFavorited = !tweet.isFavorited

        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let sdvc = segue.destinationViewController
        
        if let sdvc = sdvc as? ProfileViewController {
            sdvc.user = tweet.user
        }
        
    }

}
