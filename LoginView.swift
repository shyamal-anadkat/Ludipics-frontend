//
//  LoginView.swift
//  LudipicsUpdated
//
//  Created by Akshansh Thakur on 6/11/16.
//  Copyright © 2016 Akshansh Thakur. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginView: UIViewController, UITextFieldDelegate
{
    
    var emailText = customTextField()
    var passwordText = customTextField()
    var signinButton = UIButton()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var fbLoginButton = FBSDKLoginButton()
    var imageTri = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /****  This block initializes the tri image, adds images to view hierarchy and adds facebook login button  ****/
        self.imageTri.image = UIImage(named: "triangle")
        self.view.addSubview(imageTri)
        
        self.fbLoginButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.fbLoginButton.readPermissions = ["public_profile", "email", "user_friends"]
        self.fbLoginButton.center.x = self.view.center.x
        self.fbLoginButton.center.y = (self.view.frame.height/3) + 210.0
        self.fbLoginButton.frame.size.height = 40.0
        
        self.fbLoginButton.layer.cornerRadius = 18.0
        
        self.view.addSubview(self.fbLoginButton)
        
        self.view.addConstraints([self.fbLoginButton.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor, constant: 40.0), self.fbLoginButton.rightAnchor.constraintEqualToAnchor(self.view.rightAnchor, constant: -40.0), self.fbLoginButton.topAnchor.constraintEqualToAnchor(self.view.topAnchor, constant: self.view.frame.height/3 + 210.0), self.fbLoginButton.heightAnchor.constraintEqualToAnchor(nil, constant: 40.0)])
        
    
    
        /****                           ****/

        /**** Following block calls methods to configure the background image views/ text fields/ buttons ****/
        self.configureImageViews()
        
        self.view.addSubview(emailText)
        self.view.addSubview(passwordText)
        self.view.addSubview(signinButton) // add to hierarchy before attempting constraints on subviews
        
        self.configureButtons()
        self.configureTextFields()
        self.configureTransButtons()
        
        self.view.bringSubviewToFront(self.fbLoginButton)   // bring facebook button to front after configuring gradient images

        /****                               ****/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    /**** This method, configures text fields (username/password)  ****/
    func configureTextFields() {
        
        self.view.bringSubviewToFront(emailText)
        self.view.bringSubviewToFront(passwordText)
        
        self.emailText.translatesAutoresizingMaskIntoConstraints = false
        self.passwordText.translatesAutoresizingMaskIntoConstraints = false
        
        self.emailText.autocapitalizationType = .None
        self.passwordText.autocapitalizationType = .None
        
        self.emailText.layer.masksToBounds = false
        self.emailText.layer.shadowRadius = 2.0
        self.emailText.layer.shadowColor = UIColor.lightGrayColor().CGColor
        self.emailText.layer.shadowOffset = CGSizeMake(1.0, 1.0)
        self.emailText.layer.shadowOpacity = 1.0
        self.emailText.layer.shadowRadius = 1.0
        
        self.passwordText.layer.masksToBounds = false
        self.passwordText.layer.shadowRadius = 2.0
        self.passwordText.layer.shadowColor = UIColor.lightGrayColor().CGColor
        self.passwordText.layer.shadowOffset = CGSizeMake(1.0, 1.0)
        self.passwordText.layer.shadowOpacity = 1.0
        self.passwordText.layer.shadowRadius = 1.0
        
        self.emailText.layer.cornerRadius = 20.0
        self.passwordText.layer.cornerRadius = 20.0
        
        self.passwordText.alpha = 1.0
        self.emailText.alpha = 1.0
        
        self.emailText.clearButtonMode = .WhileEditing
        self.passwordText.clearButtonMode = .WhileEditing
        
        self.emailText.keyboardType = .EmailAddress
        self.passwordText.keyboardType = .ASCIICapable
        
        self.emailText.returnKeyType = .Next
        self.passwordText.returnKeyType = .Done
        
        self.passwordText.secureTextEntry = true
        
        self.emailText.autocorrectionType = .No
        self.passwordText.autocorrectionType = .No
        
        self.emailText.spellCheckingType = .No
        self.passwordText.spellCheckingType = .No
        
       
        
        self.passwordText.backgroundColor = UIColor.whiteColor()
        self.emailText.backgroundColor = UIColor.whiteColor()
        

        let textFieldFont = UIFont(name: "HelveticaNeue-Medium", size: 14.0)
        
        self.emailText.attributedPlaceholder =
            NSAttributedString(string: "Username", attributes: [NSForegroundColorAttributeName : UIColor(red: 246.0/255.0, green: 123.0/255.0, blue: 125.0/255.0, alpha: 1.0),
                NSFontAttributeName : textFieldFont!,])
        
        self.passwordText.attributedPlaceholder =
            NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName : UIColor(red: 246.0/255.0, green: 123.0/255.0, blue: 125.0/255.0, alpha: 1.0),
                NSFontAttributeName : textFieldFont!,])
        
        self.view.addConstraints([self.emailText.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor, constant: 30.0), self.emailText.rightAnchor.constraintEqualToAnchor(self.view.rightAnchor, constant: -30.0), self.emailText.topAnchor.constraintEqualToAnchor(self.view.topAnchor, constant: self.view.frame.height/3 + 60.0), self.emailText.heightAnchor.constraintEqualToAnchor(nil, constant: 40.0)])
        
        self.view.addConstraints([self.passwordText.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor, constant: 30.0), self.passwordText.rightAnchor.constraintEqualToAnchor(self.view.rightAnchor, constant: -30.0), self.passwordText.topAnchor.constraintEqualToAnchor(self.view.topAnchor, constant: self.view.frame.height/3 + 103.0), self.passwordText.heightAnchor.constraintEqualToAnchor(nil, constant: 40.0)])
    }
    
    
    
    /****  add buttons Sign In/ Sign Up ****/
    // Note : the follwing method is missing constraints as of yet, I will add them later after some issues are sorted
    func configureButtons() {
        
        self.view.bringSubviewToFront(self.imageTri)
        
        
        let SignUpButton = UIButton(frame: CGRect(origin: CGPoint(x: 20.0, y: view.frame.height/3 - 67.0), size: CGSize(width: 100.0, height: 60.0)))
        let LoginButton = UIButton(frame: CGRect(origin: CGPoint(x: view.frame.width - 120.0, y: view.frame.height/3 - 67.0), size: CGSize(width: 100.0, height: 60.0)))
        
        self.imageTri.frame = CGRect(origin: CGPoint(x: view.frame.width - 97.0, y: view.frame.height/3 - 37.0), size: CGSize(width: 60.0, height: 60.0))
        
        let textColor = UIColor(red: 138.0/255.0, green: 23.0/255.0, blue: 37.0/255.0, alpha: 1.0)
        
        
        
       // LoginButton.translatesAutoresizingMaskIntoConstraints = false
       // SignUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(LoginButton)
        view.addSubview(SignUpButton)
        
        LoginButton.setTitle("Log In", forState: .Normal)
        SignUpButton.setTitle("Sign Up", forState: .Normal)
        
        SignUpButton.setTitleColor(textColor, forState: .Normal)
        LoginButton.setTitleColor(textColor, forState: .Normal)
        
        SignUpButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 22.0)
        LoginButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 22.0)
        
        let constraints = [NSLayoutConstraint()]
        
        
        view.bringSubviewToFront(LoginButton)
        view.bringSubviewToFront(SignUpButton)
        
    }
    
    
    /****      This method configures the background image views and the logo     ****/
    func configureImageViews() {
        
        let logoMainImageView = UIImageView(image: UIImage(named: "LogoMain"))
        let backGroundImageView1 = UIImageView(image: UIImage(named: "customBackGround"))
        let backGroundImageView2 = UIImageView(image: UIImage(named: "customBackGround"))
        let backGroundImageView3 = UIImageView(image: UIImage(named: "customBackGroundDark"))
        
        logoMainImageView.translatesAutoresizingMaskIntoConstraints = false
        backGroundImageView1.translatesAutoresizingMaskIntoConstraints = false
        backGroundImageView2.translatesAutoresizingMaskIntoConstraints = false
        backGroundImageView3.translatesAutoresizingMaskIntoConstraints = false
        
        backGroundImageView1.alpha = 0.40
        backGroundImageView2.alpha = 0.40
        backGroundImageView3.alpha = 1.0
        
        
        logoMainImageView.frame.size = CGSizeMake(240.0, 100.0)
        logoMainImageView.center = CGPoint(x: view.center.x, y: 65.0)
        backGroundImageView1.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/3 + 20.0)
        backGroundImageView2.frame = CGRect(x: 0, y: view.frame.height/3 + 20.0, width: view.frame.width, height: view.frame.height/3 + 20.0)
        backGroundImageView3.frame = CGRect(x: 0, y: 2*(view.frame.height/3) + 40.0, width: view.frame.width, height: view.frame.height/3 - 40.0)
        
        
        view.addSubview(logoMainImageView)
        view.addSubview(backGroundImageView1)
        view.addSubview(backGroundImageView2)
        view.addSubview(backGroundImageView3)
        
        view.bringSubviewToFront(logoMainImageView)
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(logoMainImageView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor))
        constraints.append(logoMainImageView.widthAnchor.constraintEqualToAnchor(nil, constant: 240.0))
        constraints.append(logoMainImageView.heightAnchor.constraintEqualToAnchor(nil, constant: 100.0))
        constraints.append(logoMainImageView.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 65.0))
        
        constraints.append(backGroundImageView1.widthAnchor.constraintEqualToAnchor(view.widthAnchor))
        constraints.append(backGroundImageView1.heightAnchor.constraintEqualToAnchor(nil, constant: view.frame.height/3 + 20.0))
        constraints.append(backGroundImageView1.topAnchor.constraintEqualToAnchor(view.topAnchor))
        constraints.append(backGroundImageView1.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor))
        
        
        constraints.append(backGroundImageView2.widthAnchor.constraintEqualToAnchor(view.widthAnchor))
        constraints.append(backGroundImageView2.heightAnchor.constraintEqualToAnchor(nil, constant: view.frame.height/3 + 20.0))
        constraints.append(backGroundImageView2.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor))
        constraints.append(backGroundImageView2.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: view.frame.height/3 + 20.0))
        
        constraints.append(backGroundImageView3.widthAnchor.constraintEqualToAnchor(view.widthAnchor))
        constraints.append(backGroundImageView3.heightAnchor.constraintEqualToAnchor(nil, constant: view.frame.height/3 - 40.0))
        constraints.append(backGroundImageView3.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor))
        constraints.append(backGroundImageView3.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor))
        
        view.addConstraints(constraints)
    }
    
    
    
    /**** Override method to sort touches outside textfield editing rect ****/
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        let  touch: UITouch = touches.first!
        if touch.phase == .Began {
            self.emailText.resignFirstResponder()
            self.passwordText.resignFirstResponder()
            self.view.frame.origin.y = 0
        }
    }
    
    
    
    /****  The login button is one of the trans buttons (the other would be sign up), trans here is transition to other views upon successful login. ****/
    func configureTransButtons() {
        
        self.view.bringSubviewToFront(self.signinButton)
        
        
        self.signinButton.translatesAutoresizingMaskIntoConstraints = false

        self.signinButton.layer.masksToBounds = false
        self.signinButton.layer.shadowRadius = 2.0
        self.signinButton.layer.shadowColor = UIColor.lightGrayColor().CGColor
        self.signinButton.layer.shadowOffset = CGSizeMake(1.0, 1.0)
        self.signinButton.layer.shadowOpacity = 1.0
        self.signinButton.layer.shadowRadius = 1.0
        self.signinButton.layer.cornerRadius = 20.0
        
        
        self.signinButton.setTitle("Log In", forState: .Normal)
        
        let customTextColor = UIColor(red: 246.0/255.0, green: 123.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        
        self.signinButton.setTitleColor(customTextColor, forState: .Normal)
        
    
        self.signinButton.setTitleShadowColor(UIColor.darkGrayColor(), forState: .Normal)
        
        self.signinButton.addTarget(self, action: #selector(LoginView.signinButtonPressed(_:)), forControlEvents: .TouchUpInside)
        
        self.signinButton.backgroundColor = UIColor.whiteColor()
        
        self.view.addConstraints([self.signinButton.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor, constant: 105.0), self.signinButton.rightAnchor.constraintEqualToAnchor(self.view.rightAnchor, constant: -105.0), self.signinButton.topAnchor.constraintEqualToAnchor(self.view.topAnchor, constant: self.view.frame.height/3 + 160.0), self.signinButton.heightAnchor.constraintEqualToAnchor(nil, constant: 40.0)])
        
            }
    
    
    /*** Need to add more functionality to this ****/
    func signinButtonPressed(sender: AnyObject) {
        
        if self.checkEmail() && self.checkPassword() {
        // do the login request
            PFUser.logInWithUsernameInBackground(self.emailText.text!, password: self.passwordText.text!, block: { (user, error) -> Void in
                
               
                
                if user != nil {
                    
                    //logged in
                    let storyboard = UIStoryboard(name: "GroupVC", bundle: nil)
                    let controller = storyboard.instantiateViewControllerWithIdentifier("GroupVCID") as UIViewController
                    self.presentViewController(controller, animated: true, completion: nil)
                    
                    
                } else {
                    
                    print("user is nil.")
                
                    let alert = UIAlertController(title: "Failed Login",
                        message: "Your username/password is incorrect. Please try again",
                        preferredStyle: UIAlertControllerStyle.Alert
                    )
                    
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { action in
                        
                        
                    }))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            })

        }
        else {
           
        }
        
        
    }
    
    
    /*** Tests if email is fine ****/
    func checkEmail() -> Bool
    {
        var bool = true
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        bool = emailTest.evaluateWithObject(self.emailText.text!)
        
        
        if(self.emailText.text!.characters.count == 0)
        {
            bool = false
            let alert = UIAlertController(title: "Invalid Email",
                                          message: "Please enter a valid email",
                                          preferredStyle: UIAlertControllerStyle.Alert
            )
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { action in
                
                
            }))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
            
        }
        
        if bool == true
        {
            return true
        }
        else
        {
            
            let alert = UIAlertController(title: "Invalid Email",
                                          message: "Please enter a valid email",
                                          preferredStyle: UIAlertControllerStyle.Alert
            )
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { action in
                
                
            }))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
            
        }
    }

    /**** Password regex ****/
    func checkPassword() -> Bool
    {
        let bool = self.passwordText.text!.characters.count >= 6
        
        if bool == true
        {
            return true
        }
        else
        {
            let alert = UIAlertController(title: "Re-Enter Password",
                                          message: "Password must be at least 6 characters long",
                                          preferredStyle: UIAlertControllerStyle.Alert
            )
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { action in
                
                
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        }
    }

    
}
