//
//  TableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Shyamal Anadkat on 2016-03-21.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class TableViewController: UITableViewController {
    
    //arrays to store users and userIDs
    var usernames = [""]
    var userids = [""]
    var isFollowing = ["":false]
    
    var refresher:UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //pull to refresh 
        
        
        
        
        //loading users in the table view -> query for PF user
        
        var query = PFUser.query()
        query?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            
            if let users = objects {
                
                
                //remove added and stored ones so u dont get same users again
                self.usernames.removeAll(keepCapacity: true)
                self.userids.removeAll(keepCapacity: true)
                self.isFollowing.removeAll(keepCapacity: true)
                
                //update arrays 
                
                for object in users {
                    
                    if let user = object as? PFUser {
                        //we have PFUser now casted
                        
                        //current user should not appear on the list
                        if user.objectId != PFUser.currentUser()?.objectId{
                            
                            //append user info - confident that these exist
                            self.usernames.append(user.username!)
                            self.userids.append(user.objectId!)
                            
                            //print(PFUser.currentUser()?.objectId)
                            //print(PFUser.currentUser())
                            //to generate follow checks on next app run
                            var query = PFQuery(className: "Followers")
                            
                            
                            query.whereKey("follower", equalTo: PFUser.currentUser()!.objectId!)
                            query.whereKey("following", equalTo: user.objectId!)
                            
                            query.findObjectsInBackgroundWithBlock({ (objects, error ) -> Void in
                                
                                //user must be following another user
                                if let objects = objects {
                                    //store info in array
                                    
                                    if objects.count > 0 {   //can only be 0 or 1
                                    
                                    self.isFollowing[user.objectId!] = true
                                    
                                } else {
                                    self.isFollowing[user.objectId!] = false
                                }
                                }
                                //check if update when same number of usernames as isFollowings
                                if self.isFollowing.count == self.usernames.count {
                                
                                self.tableView.reloadData()
                                }
                                
                            })
                        }
                        
                        
                        
                    }
                }
                
            }
         
            
        })

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usernames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // Configure the cell...
        //populate users in the table
        cell.textLabel?.text = usernames[indexPath.row]
        let followedObjectId = userids[indexPath.row]
        
        //user id check with followed
        if isFollowing[followedObjectId] == true {
            
        cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }

        return cell
    }
 
    
    //user list click interface
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
       // print (indexPath.row)
        
        
        var cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        let followedObjectId = userids[indexPath.row]
        //if user not following them
        if isFollowing[followedObjectId] == false {
        
        isFollowing[followedObjectId] = true
        
        
        
        cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        
        var following = PFObject(className: "Followers")
        //get followers - interaction when tapped user in list
        following["following"] = userids[indexPath.row]
        following["follower"] = PFUser.currentUser()?.objectId
        
        //dont need to do anything
        following.saveInBackground()
        } else {
            
            isFollowing[followedObjectId] = false
            cell.accessoryType = UITableViewCellAccessoryType.None
            
            
            var query = PFQuery(className: "Followers")
            
            
            query.whereKey("follower", equalTo: PFUser.currentUser()!.objectId!)
            query.whereKey("following", equalTo: userids[indexPath.row])
            
            query.findObjectsInBackgroundWithBlock({ (objects, error ) -> Void in
                
                //user must be following another user
                if let objects = objects {
                    //store info in array
                    
                    for object in objects {
                        object.deleteInBackground()
                    }
                }
                //check if update when same number of usernames as isFollowings
                //if self.isFollowing.count == self.usernames.count {
                    
                //    self.tableView.reloadData()
                //}
                
            })
            
        }
    }

}
