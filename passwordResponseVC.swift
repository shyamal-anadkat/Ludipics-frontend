//
//  passwordResponseVC.swift
//  LudipicsUpdated
//
//  Copyright © 2016 Ludipics.  All rights reserved.
//

import UIKit

class passwordResponseVC: UIViewController {

    @IBOutlet var passwordPrompt: UITextField!
    @IBOutlet var name: String!
    @IBOutlet var email: String!
    
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

    @IBAction func checkPassword()
    {
        let bool = self.passwordPrompt.text?.characters.count >= 6
        
        if bool == true
        {
            //let vc: UIViewController = UIViewController(nibName: "DateGenderVC", bundle: nil)
            //self.presentViewController(vc, animated: true, completion: nil)
            performSegueWithIdentifier("segueTest3", sender: nil)
        }
        else
        {
            displayAlert("Invalid Password", message:"Make sure your password is at least 6 characters")
        }
    }
    
    override func prepareForSegue(segue:UIStoryboardSegue, sender:AnyObject!) {
        if(segue.identifier == "segueTest3") {
            let svc = segue.destinationViewController as! DateGenderVC
            svc.name = name
            svc.email = email
            svc.password = passwordPrompt.text!
        }
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
