//
//  ViewController.swift
//  LudipicsTm
//
//  Copyright © 2016 Ludipics. All rights reserved.
//

import UIKit

class Login:  UIViewController, UITextFieldDelegate{
    
    
    
    //if user already signed up
    var signupActive = true
    
    //username text field
    @IBOutlet var username: UITextField!
    
    //password text field
    @IBOutlet var password: UITextField!
    
    //sign up button
    
    
    //login button for user
    
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        })))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func loginPressed() {
        //ignore user events till sign up is performed
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0,0,50,50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        
        //let something: Bool = false
        
        if username.text ==  ""  || password.text == "" {
            // Setting up error and spinner before we login and signup process
            
            displayAlert("Invalid Attempt", message: "Please enter a valid username and password")
        }
        
        // Write code for the condition if the user has wrong pair of username/ password
        // Login process
        PFUser.logInWithUsernameInBackground(username.text!, password: password.text!, block: { (user, error) -> Void in
            
            self.activityIndicator.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            
            if user != nil {
                
                //logged in
                let storyboard = UIStoryboard(name: "GroupVC", bundle: nil)
                let controller = storyboard.instantiateViewControllerWithIdentifier("GroupVCID") as UIViewController
                self.presentViewController(controller, animated: true, completion: nil)
                
                
            } else {
                
                print("user is nil.")
                self.displayAlert("Failed Login", message: "Your username/password is incorrect. Please try again.")
            }
        })
        
    }
    
    // Write code for the condition if the user has wrong pair of username/ password
    
    
    
    
    
    @IBAction func signUpButton() {
        let storyboard = UIStoryboard(name: "SignUpVC", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("SignUpVCID") as UIViewController
        self.presentViewController(controller, animated: true, completion: nil)
    }
    //activity indicator
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    //end editing when touched -- text field. basically, keyboard goes away
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

