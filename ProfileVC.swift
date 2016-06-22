//
//  ProfileVC.swift
//  LudipicsUpdated
//
//  Created by Sanjay Rajmohan on 6/21/16.
//  Copyright © 2016 Sanjay Rajmohan. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var profileTab: UITabBar!
    
    @IBOutlet weak var currentPosts: UITabBarItem!
    
    @IBOutlet var settingsButton: UIBarButtonItem!
    
    @IBOutlet weak var profileBar: UINavigationItem!
    
    @IBOutlet var profilePicture: UIImageView!
    
    @IBOutlet weak var toolbar1: UIToolbar!
    
    @IBOutlet var coverPicture: UIImageView!
    
    func onePixelImageWithColor(color : UIColor) -> UIImage {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue)
        let context = CGBitmapContextCreate(nil, 1, 1, 8, 0, colorSpace, bitmapInfo.rawValue)
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, CGRectMake(0, 0, 1, 1))
        let image = UIImage(CGImage: CGBitmapContextCreateImage(context)!)
        return image
    }    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.settingsButton.title = NSString(string: "\u{2699}") as String
        if let font = UIFont(name: "Helvetica", size: 18.0) {
            self.settingsButton.setTitleTextAttributes([NSFontAttributeName: font], forState: UIControlState.Normal)
        }
        
        profilePicture.layer.borderWidth = 1
        profilePicture.layer.masksToBounds = false
        profilePicture.layer.borderColor = UIColor.whiteColor().CGColor
        profilePicture.layer.cornerRadius = profilePicture.frame.height/2
        profilePicture.clipsToBounds = true
        
        let bgImageColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
        
        toolbar1.setBackgroundImage(onePixelImageWithColor(bgImageColor),
                                   forToolbarPosition: UIBarPosition.Bottom,
                                   barMetrics: UIBarMetrics.Default)
        
        profileTab.addBottomBorderWithColor(UIColor.lightGrayColor(), width: 0.5)
        
        //let image:UIImage = UIImage(named: "Top Header")!
        //self.navigationItem.titleView = UIImageView(image: image)
        
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -12)
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont.systemFontOfSize(18)], forState: .Normal)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
