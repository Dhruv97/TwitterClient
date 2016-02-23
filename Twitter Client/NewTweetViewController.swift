//
//  NewTweetViewController.swift
//  Twitter Client
//
//  Created by Dhruv Upadhyay on 2/23/16.
//  Copyright © 2016 Dhruv Upadhyay. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        textView.delegate = self
        // Do any additional setup after loading the view.
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

    @IBAction func onTweet(sender: AnyObject) {
        TwitterClient.sharedInstance.tweet(textView.text)
        dismissViewControllerAnimated(true) { () -> Void in
        }
    }
    
    @IBAction func close(sender: AnyObject) {
        
        dismissViewControllerAnimated(true) { () -> Void in
        }
    }
}
