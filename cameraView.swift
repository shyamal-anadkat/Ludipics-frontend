//
//  cameraView.swift
//  LudipicsUpdated
//
//  Created by Akshansh Thakur on 6/19/16.
//  Copyright © 2016 Akshansh Thakur. All rights reserved.
//

import UIKit

class cameraView: UIViewController, CACameraSessionDelegate {

    var cameraV = CameraSessionView()
    var cancelButton = UIButton()
    var imageView = UIImageView()
    var postToImage = UIButton()
    var crossImage = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.postToImage.setImage(UIImage(named: "post"), forState: .Normal)
        self.postToImage.addTarget(self, action: #selector(cameraView.postToLudi), forControlEvents: .TouchUpInside)
        
        self.crossImage.setImage(UIImage(named: "cross"), forState: .Normal)
        self.crossImage.addTarget(self, action: #selector(cameraView.sendImageAway), forControlEvents: .TouchUpInside)
        
        self.imageView.frame = self.view.frame
        self.crossImage.frame = CGRect(origin: CGPoint(x: self.view.frame.origin.x + 15.0, y: self.view.frame.origin.y + 15.0), size: CGSize(width: 40.0, height: 40.0))
        self.postToImage.frame = CGRect(origin: CGPoint(x: self.view.frame.width - 75.0, y: self.view.frame.height - 55.0), size: CGSize(width: 65.0, height: 44.0))
        
        
        self.imageView.tag = 1000
        self.crossImage.tag = 1001
        self.postToImage.tag = 1002
        
        self.navigationController?.navigationBar.hidden = true
        
        self.cameraV = CameraSessionView(frame: self.view.frame)
        self.cancelButton.setTitle("Cancel", forState: .Normal)
        self.cancelButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.cancelButton.frame = CGRect(origin: CGPoint(x: self.view.frame.origin.x + 10.0, y: self.view.frame.origin.y + 3.0), size: CGSize(width: 120.0, height: 40.0))
        self.cancelButton.addTarget(self, action: #selector(cameraView.switchTab), forControlEvents: .TouchUpInside)
        
        
        let font = UIFont(name: "HelveticaNeue-Medium", size: 18.0)
        
        let mySelectedAttributedTitle = NSAttributedString(string: "Cancel",
                                                           attributes: [NSForegroundColorAttributeName : UIColor(red: 161.0/255.0, green: 67.0/255.0, blue: 82.0/255.0, alpha: 1.0),
                                                            NSFontAttributeName : font!])
        
        self.cancelButton.setAttributedTitle(mySelectedAttributedTitle, forState: .Normal)
        self.cancelButton.contentHorizontalAlignment = .Left
        self.cameraV.delegate = self
        self.view.addSubview(self.cameraV)
        
        self.view.addSubview(self.cancelButton)
        
    }
    
    func postToLudi() {
        self.performSegueWithIdentifier("postTo", sender: self)
    }
    
    func didCaptureImage(image: UIImage!) {
        self.imageView.image = image
        self.view.addSubview(self.imageView)
        self.view.addSubview(crossImage)
        self.view.addSubview(self.postToImage)
        self.cameraV.hidden = true
        self.cancelButton.hidden = true
        
    }
    
    func switchTab() {
        self.tabBarController?.selectedIndex = 0
    }
    
    func sendImageAway() {
        
        self.cameraV.hidden = false
        self.cancelButton.hidden = false
        
        
        let views = self.view.subviews
        for EveryView in views {
            if EveryView.tag == 1000 {
                EveryView.removeFromSuperview()
            }
            
            if EveryView.tag == 1001 {
                EveryView.removeFromSuperview()
            }
            
            if EveryView.tag == 1002 {
                EveryView.removeFromSuperview()
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true
        self.navigationController?.navigationBar.hidden = true
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "postTo" {
            segue.destinationViewController as! postTOVC
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    /*
    _cameraView = [[CameraSessionView alloc] initWithFrame:self.view.frame];
    _cameraView.delegate = self;
    [self.view addSubview:_cameraView];
    */
}

