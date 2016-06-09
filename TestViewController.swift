//
//  TestViewController.swift
//  LudipicsUpdated
//
//  Created by Akshansh Thakur on 4/26/16.
//  Copyright © 2016 Akshansh Thakur. All rights reserved.
//

import UIKit

@objc class TestViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var navTitle: UINavigationItem!
    
    var DetailMod: [AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

}
