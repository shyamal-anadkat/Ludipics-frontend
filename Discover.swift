//
//  Discover.swift
//  LudipicsUpdated
//
//  Created by Akshansh Thakur on 6/9/16.
//  Copyright © 2016 Akshansh Thakur. All rights reserved.
//

import UIKit
import Parse

class Discover: UITableViewController {

    //*** logs out user and navigates back to login-signup screen ***//
    @IBAction func logout(sender: UIBarButtonItem) {
     
        
        PFUser.logOut()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("loginVCID") as UIViewController
        self.presentViewController(controller, animated: true, completion: nil)
    }
}

