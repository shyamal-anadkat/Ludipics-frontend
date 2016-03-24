/**
 * Copyright (c) Ludipics LLC
 * Credits : Parse LLC
 * All rights reserved.
 *
 */

// Initial view controller.
// Please keep the code clean and comment everywhere. - shyamal
// This is Ludipics and this is our lifestyle.

import UIKit
import Parse

class ViewController: UIViewController, UITextFieldDelegate{
    
    //if user already signed up
    var signupActive = true
    
    //username text field
    @IBOutlet var username: UITextField!
    
    //password text field
    @IBOutlet var password: UITextField!
    
    //sign up button
    @IBOutlet var signupButton: UIButton!
    
    //registered text field
    @IBOutlet var registeredText: UILabel!
    
    //login button for user
    @IBOutlet var loginButton: UIButton!
    
    //activity indicator
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    //end editing when touched -- text field. basically, keyboard goes away
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    //just use this function when you want to display pop up alert
    func displayAlert(title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        })))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    //Allows user to sign up and send user info to server
    @IBAction func signUp(sender: AnyObject) {
        
        if username.text ==  ""  || password.text == "" {
            // Setting up error and spinner before we login and signup process
            
            displayAlert("Error in form", message: "Please enter a username and password")
        } else {
            
            //ignore user events till sign up is performed
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0,0,50,50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            var errorMessage = "Sorry. Please try again later"
            
            if signupActive == true {
                
                //Creates a PF user with username and password
                var user = PFUser()
                user.username = username.text
                user.password = password.text
            
                //Sign up in background
                user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if error == nil {
                        
                        //signup success!
                        print("done signup")
                        self.performSegueWithIdentifier("login", sender: self)
                        
                    } else {
                        if let errorString = error!.userInfo["error"] as? String {
                            errorMessage = errorString
                            print("signup error")
                        }
                        self.displayAlert("Failed Signup", message: errorMessage)
                    }
                })
            } else {
                // Login process
                PFUser.logInWithUsernameInBackground(username.text!, password: password.text!, block: { (user, error) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if user != nil {
                        
                        //logged in
                        
                        self.performSegueWithIdentifier("login", sender: self)
                        
                    } else {
                        
                        print("user is nil.")
                        if let errorString = error!.userInfo["error"] as? String {
                            errorMessage = errorString
                        }
                        self.displayAlert("Failed Login", message: errorMessage)
                    }
                })
            }
        }
    }
    
    @IBAction func login(sender: AnyObject) {
        
        //switch to login or sign up views
        
        if signupActive == true {
            
            signupButton.setTitle("Log In", forState: UIControlState.Normal)
            
            registeredText.text = "        Sign me Up"
            
            loginButton.setTitle("Sign Up", forState: UIControlState.Normal)
            
            signupActive = false
            
        } else {
            
            signupButton.setTitle("Sign Up", forState: UIControlState.Normal)
            
            registeredText.text = "         Let me in !"
            
            loginButton.setTitle("Login", forState: UIControlState.Normal)
            
            signupActive = true
        }
      
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //so this is to hide keyboard after return is pressed on it
        self.username.delegate = self
        self.password.delegate = self
    }
    
    //segue if user already logged in
    override func viewDidAppear(animated: Bool) {
       
        //hide navigation controller once logout is pressed
        if let navController = self.navigationController {
            navController.navigationBarHidden = true
            self.navigationController?.toolbarHidden = true
        }
        
        //right now it logouts user once app is closed
        //PFUser.logOut()
        
        //login user is current user is not nil and object id is not nil
        if PFUser.currentUser() != nil && PFUser.currentUser()?.objectId != nil {
            self.performSegueWithIdentifier("login", sender: self)
        } 
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // exits keyboard when return is pressed
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
