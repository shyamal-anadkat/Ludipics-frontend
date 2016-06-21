//
//  GroupVC.swift
//  LudipicsUpdated
//
//  Created by Akshansh Thakur on 6/21/16.
//  Copyright © 2016 Akshansh Thakur. All rights reserved.
//

import UIKit

class GroupVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var segmentControl : UISegmentedControl!
    var tableView : UITableView!
    
    
    var GroupNames = ["Stranger Shenanigans", "Night Life", "College Life", "Artsy", "People Watching"]
    var ImageNames = ["StrangerSh", "Nightlife", "college-life", "Artsy", "peoplewatching"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.translucent = false
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navBar"),
                                                                    forBarMetrics: .Default)
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "logoNav"))
        
        
        segmentControl = UISegmentedControl(items: ["Public", "Local"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.frame.origin.y = self.view.frame.origin.y
        segmentControl.frame.size.height = 45.0
        segmentControl.frame.size.width = self.view.frame.width
        segmentControl.tintColor = UIColor(red: 161.0/255.0, green: 67.0/255.0, blue: 82.0/255.0, alpha: 1.0)
        segmentControl.setTitleTextAttributes([
            NSFontAttributeName : UIFont(name: "HelveticaNeue-Medium", size: 16.0)!,
            NSForegroundColorAttributeName : UIColor(red: 161.0/255.0, green: 67.0/255.0, blue: 82.0/255.0, alpha: 1.0)
            ], forState: .Normal)
        segmentControl.addTarget(self, action: #selector(GroupVC.segmentSelected), forControlEvents: .ValueChanged)
        
        
        
        tableView = UITableView(frame: CGRect(x: 0, y: 45.0, width: self.view.frame.width, height: self.view.frame.height - 45.0))
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIColor(red: 231.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        tableView.delegate = self
        tableView.dataSource = self
        // tableView.setEditing(true, animated: true)
        
        self.view.addSubview(segmentControl)
        self.view.addSubview(tableView)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if segmentControl.selectedSegmentIndex == 0 {
            return 1
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if segmentControl.selectedSegmentIndex == 0 {
            return 100.0
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        self.tableView.tableFooterView = UIView()
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.selectionStyle = .None
    
        let views = cell.contentView.subviews
        if views.count != 0 {
            for view in views {
                view.removeFromSuperview()
            }
        }
        
        
        if segmentControl.selectedSegmentIndex == 0 {
            
            cell.accessoryType = .DisclosureIndicator
            
            let nameLabel = UILabel()
            let followersLabel = UILabel()
            let ImageView = UIImageView(image: UIImage(named: self.ImageNames[indexPath.section]))
            let followerIcon = UIImageView(image: UIImage(named: "followerIcon"))
            
            ImageView.frame = CGRect(x: cell.contentView.frame.origin.x + 10.0, y: cell.contentView.frame.origin.y + 10.0, width: 80, height: 80.0)
            
            nameLabel.frame = CGRect(x: cell.contentView.frame.origin.x + 110.0, y: cell.contentView.frame.origin.y + 10.0, width: 200, height: 50.0)
            followersLabel.frame = CGRect(x: cell.contentView.frame.origin.x + 145.0, y: cell.contentView.frame.origin.y + 60.0, width: 200, height: 30.0)
            followerIcon.frame = CGRect(x: cell.contentView.frame.origin.x + 110.0, y: cell.contentView.frame.origin.y + 60.0, width: 30, height: 30.0)
            
            
            
            let nameLabelAttributes  = NSAttributedString(string: self.GroupNames[indexPath.section], attributes: [
                NSForegroundColorAttributeName : UIColor.blackColor(),
                NSFontAttributeName : UIFont(name: "HelveticaNeue-Medium", size: 16.0)!
                ]
            )
            
            let followerLabelAttributes = NSAttributedString(string: "\(Int(arc4random_uniform(10000) + 1))" + " followers", attributes: [
                NSForegroundColorAttributeName : UIColor.grayColor(),
                NSFontAttributeName : UIFont(name: "HelveticaNeue-Medium", size: 14.0)!
                ]
            )
            
            nameLabel.attributedText = nameLabelAttributes
            followersLabel.attributedText = followerLabelAttributes
            
            //nameLabel.text =
            //followersLabel.text =
            
            ImageView.layer.cornerRadius = 40.0
            ImageView.clipsToBounds = true
            
            ImageView.layer.borderWidth = 1.0
            ImageView.layer.borderColor = UIColor(red: 161.0/255.0, green: 67.0/255.0, blue: 82.0/255.0, alpha: 1.0).CGColor
            
            cell.contentView.addSubview(followerIcon)
            cell.contentView.addSubview(nameLabel)
            cell.contentView.addSubview(followersLabel)
            cell.contentView.addSubview(ImageView)
        }
        else {
            
        }
        // Configure the cell...

        return cell
    }
    
    
    func segmentSelected() {
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if segmentControl.selectedSegmentIndex == 0 {
            return 3.0
        }
        else {
            return 0.0
        }
    }
    
    
    // Override to support conditional editing of the table view.
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        
        return true
    }
 

    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Insert
    }
    
    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

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
