//
//  ViewController.swift
//  Twitter Client
//
//  Created by Dhruv Upadhyay on 2/9/16.
//  Copyright © 2016 Dhruv Upadhyay. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class ViewController: UIViewController {
    
    
    
    
    
    
    @IBAction func onLogin(sender: AnyObject) {
        
        TwitterClient.sharedInstance.loginWithCompletion() {
            
            (user: User?, error: NSError?) in
            if user != nil {
                // perform segue
                self.performSegueWithIdentifier("loginSegue", sender: self)
            
            } else {
                //handle error
            }
        }
        
                
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

