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

    @IBAction func Logout(sender: UIBarButtonItem) {
        PFUser.logOut()
        //PFUser.currentUser() == nil
        let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("LoginVCID") as UIViewController
        self.presentViewController(controller, animated: true, completion: nil)
        
        
        
    }
}
