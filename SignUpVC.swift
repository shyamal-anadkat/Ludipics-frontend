//
//  SignUpVC.swift
//  LudipicsUpdated
//
//  Created by Akshansh Thakur on 4/22/16.
//  Copyright © 2016 Akshansh Thakur. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    @IBAction func Cancel(sender: UIBarButtonItem) {
       self.dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    @IBOutlet var namePrompt: UITextField!
    
    
    //Declare a delegate, assign your textField to the delegate and then include these methods
    //Declare a delegate, assign your textField to the delegate and then include these methods
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
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
