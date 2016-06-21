//
//  postTOVC.swift
//  LudipicsUpdated
//
//  Created by Akshansh Thakur on 6/20/16.
//  Copyright © 2016 Akshansh Thakur. All rights reserved.
//

import UIKit

class postTOVC: UITableViewController {
    
    
    /// Temporary HardCodedArray, should be fixed when backend is integrated.
    var arrayOfStrings = ["  Stranger Shenanigans", "  Night Life", "  College Life", "  Artsy", "  People Watching"]
    
    var boolArray : [Bool] = [false, false, false, false, false]
    var searchBar : UISearchBar!
    var selectOn : Bool = false
    var bottomBar : UIView = UIView()
    var post : UIButton = UIButton()
    var bottomLabel : UILabel = UILabel()
    var bottomLabelStringArray : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Post To..."
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor(red: 140.0/255.0, green: 23.0/255.0, blue: 30.0/255.0, alpha: 1.0)]
        self.navigationController!.navigationBar.titleTextAttributes = (titleDict as! [String : AnyObject])
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 140.0/255.0, green: 23.0/255.0, blue: 30.0/255.0, alpha: 1.0)
        
        
        
        bottomLabel.frame = CGRect(x: 8.0, y: self.tableView.frame.height - 120.0, width: self.tableView.frame.width - 120.0, height: 60.0)
        bottomLabel.textColor = UIColor.whiteColor()
        bottomLabel.text = " "
        
        self.post.setImage(UIImage(named: "post2"), forState: .Normal)
        self.post.addTarget(self, action: #selector(postTOVC.postPicture), forControlEvents: .TouchUpInside)
        self.post.alpha = 0.6
        
        self.post.frame = CGRect(origin: CGPoint(x: self.tableView.frame.width - 70.0, y: self.tableView.frame.height - 115.0), size: CGSize(width: 65.0, height: 44.0))

        bottomBar.frame = CGRect(origin: CGPoint(x: self.tableView.frame.origin.x, y: self.tableView.frame.height - 120.0), size: CGSize(width: self.tableView.frame.width, height: 60.0))
        
        
        self.tableView.addSubview(bottomBar)
        self.tableView.addSubview(post)
        self.tableView.addSubview(bottomLabel)
        
        self.bottomLabel.font = UIFont(name: "", size: 10.0)
        self.bottomLabel.numberOfLines = 0
        self.bottomLabel.lineBreakMode = .ByWordWrapping
        bottomBar = configureBottomBar(bottomBar)
        
        self.tableView.tableFooterView = UIView()
    }
    
    func postPicture() {
        
    }
    
    func configureBottomBar(bottomBar: UIView) -> UIView {
        
        bottomBar.backgroundColor = UIColor(red: 140.0/255.0, green: 23.0/255.0, blue: 30.0/255.0, alpha: 0.75)
        
        return bottomBar
    }
    
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.alpha = 0.6
        cell.contentView.alpha = 0.6
        cell.layer.borderWidth = 0.6
        cell.backgroundColor = UIColor.clearColor()
        cell.layer.borderColor = UIColor(red: 223.0/255.0, green: 223.0/255.0, blue: 225.0/255.0, alpha: 1.0).CGColor
        
        
        
        if indexPath.row != 0{
            
            let label = UILabel(frame: CGRect(origin: cell.contentView.frame.origin, size: CGSize(width: cell.contentView.frame.width - 100.0, height: cell.contentView.frame.height)))
            
            label.text = self.arrayOfStrings[indexPath.row - 1]
            
            let backView = UIView(frame: CGRect(origin: cell.contentView.frame.origin, size: cell.contentView.frame.size))
            backView.backgroundColor = UIColor(red: 251/255.0, green: 237.0/255.0, blue: 220.0/255.0, alpha: 0.37)
            
            cell.contentView.addSubview(backView)
            cell.layer.masksToBounds = false
            cell.layer.shadowColor = UIColor.groupTableViewBackgroundColor().CGColor
            cell.layer.shadowOffset = CGSizeMake(1.0, 1.0)
            cell.layer.shadowOpacity = 1.0
            cell.layer.shadowRadius = 1.5
            
            var someView = UIView()
            
            someView = configAccView(someView, index : indexPath)
            
            cell.accessoryView = someView
            cell.contentView.addSubview(label)
        }
            
        else {
            self.searchBar = UISearchBar(frame: CGRect(x: cell.contentView.frame.origin.x, y: cell.contentView.frame.origin.y, width: cell.contentView.frame.width, height: 45.0))
            cell.contentView.addSubview(searchBar)
            searchBar = configureSearchBar(searchBar)
            
        }
        
        
        
        return cell
    }
    
    func configAccView(someView : UIView, index: NSIndexPath) -> UIView {
        let accView = UIButton()
        accView.layer.cornerRadius = 2.5
        
        accView.addTarget(self, action: #selector(postTOVC.cellSelected), forControlEvents: .TouchUpInside)
        
        someView.frame.size = CGSize(width: 24.0, height: 24.0)
        accView.frame.size = CGSize(width: 24.0, height: 24.0)
        
        accView.layer.borderWidth = 0.5
        accView.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        accView.layer.shadowColor = UIColor.grayColor().CGColor
        accView.layer.shadowRadius = 1.0
        
        someView.backgroundColor = UIColor.clearColor()
        accView.backgroundColor = UIColor.whiteColor()
        accView.tag = index.row
        someView.addSubview(accView)
        
        return someView
    }
    
    
    func cellSelected(sender: UIButton) {
        if self.boolArray[sender.tag - 1] {
            
            let row = sender.tag
            let text = self.arrayOfStrings[row - 1]
            if self.bottomLabelStringArray.contains(text) {
                self.bottomLabelStringArray.removeAtIndex(self.bottomLabelStringArray.indexOf(text)!)
            }
            removeFromBottomLabel()
            
            sender.backgroundColor = UIColor.whiteColor()
            sender.setImage(nil, forState: .Normal)
            self.boolArray[sender.tag - 1] = false
        }
        else {
            let row = sender.tag
            let text = self.arrayOfStrings[row - 1]
            self.bottomLabelStringArray.append(text)
            self.addToBottomLabel()
            // updateLabel(text)
            sender.backgroundColor = UIColor(red: 134.0/255.0, green: 25.0/255.0, blue: 36.0/255.0, alpha: 1.0)
            sender.setImage(UIImage(named: "tick"), forState: .Normal)
            self.boolArray[sender.tag - 1] = true
        }
    }
    
    
    func addToBottomLabel() {
        if bottomLabelStringArray.count == 0 {
            self.bottomLabel.text = bottomLabelStringArray[0]
        }
        else {
            var concatString = ""
            for string in bottomLabelStringArray {
                if concatString == "" {
                    concatString = string
                }
                else {
                    concatString = concatString + ", " + string
                }
            }
            self.bottomLabel.text = concatString
        }
    }
    
    func removeFromBottomLabel() {
        if bottomLabelStringArray.count == 0 {
            self.bottomLabel.text = ""
        }
        else {
            var concatString = ""
            for string in bottomLabelStringArray {
                if concatString == "" {
                    concatString = string
                }
                else {
                    concatString = concatString + ", " + string
                }
            }
            self.bottomLabel.text = concatString
        }

    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 45.0
        }
        else {
            return 50.0
        }
    }
    
    
    func configureSearchBar(searchBar : UISearchBar) -> UISearchBar {
        
        searchBar.autocapitalizationType = .None
        searchBar.autocorrectionType = .No
        searchBar.barTintColor = UIColor.whiteColor()
        searchBar.barStyle = .Default
        searchBar.keyboardAppearance = .Light
        searchBar.keyboardType = .ASCIICapable
        searchBar.placeholder = "Search"
        searchBar.layer.borderWidth = 0.6
        searchBar.layer.borderColor = UIColor(red: 223.0/255.0, green: 223.0/255.0, blue: 225.0/255.0, alpha: 1.0).CGColor
        searchBar.tintColor = UIColor(red: 191.0/255.0, green: 134.0/255.0, blue: 140.0/255.0, alpha: 1.0)
        return searchBar
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        let  touch: UITouch = touches.first!
        if touch.phase == .Began {
            self.searchBar.endEditing(true)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true
        self.navigationController?.navigationBar.hidden = false
        
        let backgroundImage = UIImage(named: "customBackGround")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.hidden = true
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    
}
