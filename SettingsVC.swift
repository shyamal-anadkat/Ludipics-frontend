//
//  SettingsVC.swift
//  LudipicsUpdated
//
//  Created by Sanjay Rajmohan on 6/21/16.
//  Copyright © 2016 Sanjay Rajmohan. All rights reserved.
//

import UIKit

extension UIView {
    
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.CGColor
        border.frame = CGRectMake(0, 0, self.frame.size.width, width)
        self.layer.addSublayer(border)
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.CGColor
        border.frame = CGRectMake(self.frame.size.width - width, 0, width, self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.CGColor
        border.frame = CGRectMake(0, self.frame.size.height - width, self.frame.size.width, width)
        self.layer.addSublayer(border)
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.CGColor
        border.frame = CGRectMake(0, 0, width, self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
}

class SettingsVC: UIViewController {
    
    @IBOutlet var password: UIToolbar!
    
    @IBOutlet var logout: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        password.addBottomBorderWithColor(UIColor.lightGrayColor(), width: 0.5)
        logout.addBottomBorderWithColor(UIColor.lightGrayColor(), width: 0.5)
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
}

