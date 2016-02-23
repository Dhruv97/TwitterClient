//
//  User.swift
//  Twitter Client
//
//  Created by Dhruv Upadhyay on 2/14/16.
//  Copyright © 2016 Dhruv Upadhyay. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"


class User: NSObject {

    var name: String?
    var screenname: String?
    var profileImageURL: String?
    var tagLine: String?
    var dictionary: NSDictionary
    var bgURL: String?
    var tweetNum: Int?
    var followersNum: Int?
    var followingNum: Int?
    
    init(dictionary: NSDictionary) {
        
        tweetNum = dictionary["statuses_count"] as? Int
        followersNum = dictionary["followers_count"] as? Int
        followingNum = dictionary["friends_count"] as? Int
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageURL = dictionary["profile_image_url"] as? String
        tagLine = dictionary["description"] as? String
        bgURL = dictionary["profile_background_image_url"] as? String
    
    }
    
    func logout() {
        
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    class var currentUser: User? {
        
        get {
            if _currentUser == nil {
                 var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
        
                    let dictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
        
                    _currentUser = User(dictionary: dictionary)
                }
        
            }
            return _currentUser
        }
        
        set(user) {
            
            _currentUser = user
            
            if _currentUser != nil {
                
                let data =  try! NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: [])
                
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                
                
                
            } else {
                
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
                
                NSUserDefaults.standardUserDefaults().synchronize()

                
            }
        }
    }
    
}
