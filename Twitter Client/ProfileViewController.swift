//
//  ProfileViewController.swift
//  Twitter Client
//
//  Created by Dhruv Upadhyay on 2/22/16.
//  Copyright © 2016 Dhruv Upadhyay. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var user: User!
    var tweets: [Tweet]!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var bg: UIImageView!
    
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tweetCount: UILabel!
    @IBOutlet weak var following: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        name.text = user.name
        handle.text = "@\(user.screenname!)"
        
        profileImage.setImageWithURL(NSURL(string: user.profileImageURL!)!)
        bg.setImageWithURL(NSURL(string: user.bgURL!)!)
        
        tweetCount.text = String(user.tweetNum!)
        following.text = String(user.followingNum!)
        followers.text = String(user.followersNum!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
