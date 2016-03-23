//
//  PostImageViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Shyamal Anadkat on 2016-03-21.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class PostImageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    
    func displayAlert(title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        })))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    var activityIndicator = UIActivityIndicatorView()
    
    
    @IBOutlet var ludiImage: UIImageView!
    
    @IBAction func chooseImage(sender: AnyObject) {
        //import image 
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
        
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        //dismiss view controller
        self.dismissViewControllerAnimated(true, completion: nil)
        
        ludiImage.image = image
    }
    @IBOutlet var chatImage: UITextField!
    
    
    @IBAction func postImage(sender: AnyObject) {
        
        //activity indicator code for post image stuff 
        
        activityIndicator = UIActivityIndicatorView.init(frame: self.view.frame)
        
        //fade out activity indicator for better look yeah ludipics goo goo gooo
        activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.56)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        //stop interacting while loading u know bitch
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        var post = PFObject(className: "Post")
        
        
        //TODO check if sent image has a message filled in or no
        if chatImage.text == "" {
            //displayAlert("Fill it in !", message: "I'm going to send it dry.")
        }
        
        post["message"] = chatImage.text
        
        post["userId"] = PFUser.currentUser()!.objectId!
        
        //save image as image file 
        
        let imageData = UIImageJPEGRepresentation(ludiImage.image!, 1)
        
        let imageFile = PFFile(name: "image.png", data: imageData!)
        
        post["imageFile"] = imageFile
        
        post.saveInBackgroundWithBlock { (success, error) -> Void in
            
            //activity over
            self.activityIndicator.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            
            
            if error==nil {
                
                self.displayAlert("LudaMaster says", message: "Your image has been posted.")
                 //sets default image after posted image
                self.ludiImage.image = UIImage(named: "logo.png")
                
                self.chatImage.text = ""
                
            } else {
                 //TODO extract parse error
                 self.displayAlert("LudaMaster says", message: "Please try again. Couldn't post image.")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.chatImage.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
        
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
