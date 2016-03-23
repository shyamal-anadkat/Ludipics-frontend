//
//  ConnectTableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Shyamal Anadkat on 2016-03-21.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class ConnectTableViewController: UITableViewController {
    
    //to store image data and stuff
    var messages = [String] ()
    var usernames = [String] ()
    var imageFiles = [PFFile] ()
    var users = [String: String] () //link user ids to usernames dictionary

    override func viewDidLoad() {
        super.viewDidLoad()
        //download images 
        
        
        
        var query = PFUser.query()
        query?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            
            if let users = objects {
                
                
                //remove added and stored ones so u dont get same users again
                //empty them all just in case u know
                self.messages.removeAll(keepCapacity: true)
                self.imageFiles.removeAll(keepCapacity: true)
                self.users.removeAll(keepCapacity: true)
                self.usernames.removeAll(keepCapacity: true)
                //update arrays
                
                for object in users {
                    
                    if let user = object as? PFUser {
                        //user we are interested 
                        
                        self.users[user.objectId!] = user.username!
                    }
                }
            }
        
        //search query for getting followers
        var getFollowedUsersQuery = PFQuery(className: "Followers")
        
        //want same id as follower and user
        getFollowedUsersQuery.whereKey("follower", equalTo: PFUser.currentUser()!.objectId!)
            
        getFollowedUsersQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if let objects = objects {
                //loop thru if exists 
                
                for object in objects {
                    //what info do we want ? users followed 
                    
                    //cast down to string
                    var followedUser = object["following"] as! String
                    
                    var query = PFQuery(className: "Post")
                    
                    query.whereKey("userId", equalTo: followedUser)
                    query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                        
                        if let objects = objects {
                            
                            for object in objects {
                                //save these in our app
                                
                                self.messages.append(object["message"]! as! String)
                                
                                //download image file not actual image !
                                self.imageFiles.append(object["imageFile"] as! PFFile)
                                
                                //get username for userid 
                                
                                self.usernames.append(self.users[object["userId"] as! String]!)
                                
                                self.tableView.reloadData()
                                
                            }
                            
                            print(self.users)
                            print(self.messages)
                            
                        }
                        
                    })
                    
                }
                
            }
         }
        })
    
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
        let myCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! cell
        //change type to the cell we defined
        // Configure the cell...
        
        imageFiles[indexPath.row].getDataInBackgroundWithBlock { (data, error) -> Void in
            
            if let downloadedImage = UIImage(data: data!) {
                
                myCell.postedImage.image = downloadedImage
                
                
            }
            
            
        }
        //creates 3 cells
       
        
        myCell.username.text = usernames[indexPath.row]
        
        myCell.message.text = messages[indexPath.row]
        return myCell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
