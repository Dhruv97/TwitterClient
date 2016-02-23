//
//  Tweet.swift
//  Twitter Client
//
//  Created by Dhruv Upadhyay on 2/14/16.
//  Copyright © 2016 Dhruv Upadhyay. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var dictionary: NSDictionary
    var id: Int?
    
    var retweetCount: Int!
    var favoriteCount: Int!

    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    
    var isRetweeted : Bool!
    var isFavorited : Bool!

    
    init(dictionary: NSDictionary) {
        
        self.dictionary = dictionary
        
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        favoriteCount = dictionary["favorite_count"] as! Int
        
        retweetCount = dictionary["retweet_count"] as! Int
        
        isRetweeted = dictionary["retweeted"] as! Bool
        isFavorited = dictionary["favorited"] as! Bool
        
        id = dictionary["id"] as? Int
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"

        createdAt = formatter.dateFromString(createdAtString!)
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
}
