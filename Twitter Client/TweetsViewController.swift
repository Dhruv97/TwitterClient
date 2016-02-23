//
//  TweetsViewController.swift
//  Twitter Client
//
//  Created by Dhruv Upadhyay on 2/15/16.
//  Copyright © 2016 Dhruv Upadhyay. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tweets: [Tweet]?
    var single: Tweet!

    @IBAction func profileSelect(sender: AnyObject) {
        
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! TweetCell
        let indexPath = tableView.indexPathForCell(cell)
        single = tweets![indexPath!.row]
    }
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func logoutPressed(sender: AnyObject) {
        
        User.currentUser?.logout()
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        let tweet = tweets?[indexPath.row]
        
        let time = Int((tweet?.createdAt?.timeIntervalSinceNow)!)
        
        if time/3600 == 0 {
            cell.time.text = "\(-time/60)m"
        } else if time/86400 == 0 {
            cell.time.text = "\(-time/3600)h"
        } else if time/604800 == 0 {
            cell.time.text = "\(-time/86400)d"
        }
        
        cell.info.text = tweet?.text!
        cell.username.text = tweet?.user?.name
        cell.twitterHandle.text = "@\((tweet?.user?.screenname!)!)"
        
        
        if tweet?.retweetCount != 0 && tweet?.retweetCount != nil  {
            
            cell.retweetLabel.text! = String(tweet!.retweetCount!)
            
        } else {
            cell.retweetLabel.text = ""

        }
        
        if tweet?.favoriteCount != 0 {
            
            
            cell.favLabel.text = String((tweet?.favoriteCount)!)
        
        } else {
            cell.favLabel.text = ""
        }
        
       cell.profileImage.setImageWithURL(NSURL(string: (tweet!.user!.profileImageURL)!)!)
        
       cell.id = tweet!.id
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return 20
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        single = tweets![indexPath.row]
        
        return indexPath
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        print("second")
        
        let sdvc = segue.destinationViewController
        
        if let sdvc = sdvc as? DetailViewController {
            sdvc.tweet = single
        }
            
       /* else if let dc = dc as? CreateTweetViewController {
            dc.user = User.currentUser
        }*/
            
        else if let sdvc = sdvc as? ProfileViewController {
            sdvc.user = single.user
        }
        
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
   
}
