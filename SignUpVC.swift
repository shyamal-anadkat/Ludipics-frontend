//
//  SignUpVC.swift
//  LudipicsUpdated
//
//  Copyright © 2016 Ludipics. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    @IBAction func Cancel(sender: UIBarButtonItem) {
       self.dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            //self.dismissViewControllerAnimated(true, completion: nil)
        })))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBOutlet var namePrompt: UITextField!
    
    @IBAction func checkName()
    {
        var bool = true
        let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z].*", options: NSRegularExpressionOptions())
        
        if (regex.firstMatchInString(self.namePrompt.text!, options: NSMatchingOptions() , range:NSMakeRange(0, (self.namePrompt.text?.characters.count)!)) != nil)
        {
            print("Couldn't handle special characters")
            bool = false
        }
        
        if(self.namePrompt.text?.characters.count == 0)
        {
            bool = false
        }
        
        if bool == true
        {
            self.namePrompt.text = self.namePrompt.text?.lowercaseString.capitalizedString
            //let vc: UIViewController = UIViewController(nibName: "emailResponseVC", bundle: nil)
            //self.presentViewController(vc, animated: true, completion: nil)
            performSegueWithIdentifier("segueTest1", sender: nil)
        }
        else
        {
            displayAlert("Invalid Name", message:"Please enter a valid name")
        }
    }
    
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
    
    override func prepareForSegue(segue:UIStoryboardSegue!, sender:AnyObject!) {
        if(segue.identifier == "segueTest1") {
            let svc = segue.destinationViewController as! emailResponseVC
            svc.name = namePrompt.text!
        }
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
