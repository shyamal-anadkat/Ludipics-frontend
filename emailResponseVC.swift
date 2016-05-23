//
//  emailResponseVC.swift
//  LudipicsUpdated
//
//  Copyright © 2016 Ludipics. All rights reserved.
//

import UIKit

class emailResponseVC: UIViewController {

    
    @IBOutlet var emailAddressPrompt: UITextField!
    @IBOutlet var name: String!
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
        })))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        

    }

    @IBAction func checkEmail()
    {
        var bool = true
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        bool = emailTest.evaluateWithObject(self.emailAddressPrompt.text)
        
        
        if(self.emailAddressPrompt.text?.characters.count == 0)
        {
            bool = false
        }
        
        if bool == true
        {
            self.emailAddressPrompt.text = self.emailAddressPrompt.text?.lowercaseString
            //let vc: UIViewController = UIViewController(nibName: "passwordResponseVC", bundle: nil)
            //self.presentViewController(vc, animated: true, completion: nil)
            performSegueWithIdentifier("segueTest2", sender: nil)
        }
        else
        {
            displayAlert("Invalid Email", message:"Please enter a valid email address")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
   
    override func prepareForSegue(segue:UIStoryboardSegue!, sender:AnyObject!) {
        if(segue.identifier == "segueTest2") {
            let svc = segue.destinationViewController as! passwordResponseVC
            svc.name = name
            svc.email = emailAddressPrompt.text!
        }
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
