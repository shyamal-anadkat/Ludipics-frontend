//
//  DateGenderVC.swift
//  LudipicsUpdated
//  Copyright © 2016 Ludipics. All rights reserved.
//

import UIKit

class DateGenderVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var female: UIButton!
    @IBOutlet weak var male: UIButton!
    var isHighlighted = false //is female highlighted
    var Gender: Bool = false
    
    var genderSetGet: Bool {
        get {
            return Gender
        }
        set (newValue) {
            Gender = newValue
           print(genderSetGet)
        }
        
    }
    
    
    @IBOutlet var dateLabel: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet var name: String!
    @IBOutlet var email: String!
    @IBOutlet var password: String!
    
    
     var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
        })))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = UIDatePickerMode.Date
        
        datePicker.addTarget(self, action: #selector(DateGenderVC.dateDidChange(_:)), forControlEvents: .ValueChanged)
        // Do any additional setup after loading the view.
        male.highlighted = true
        

    }
    
    @IBAction func checkDate()
    {
        var bool = true
        
        let cal = NSCalendar.currentCalendar()
        let thisComponents = cal.components([.Era, .Year, .Month, .Day], fromDate:NSDate())
        
        let birthComponents = cal.components([.Era, .Year, .Month, .Day], fromDate:datePicker.date)
        
        let years = thisComponents.year - birthComponents.year
        
        if(years >= 13)
        {
            if(years == 13)
            {
                if((thisComponents.month - birthComponents.month) >= 0)
                {
                    if(thisComponents.month == birthComponents.month)
                    {
                        if((thisComponents.day - birthComponents.day) < 0)
                        {
                            bool = false
                        }
                        
                    }
                }
                else
                {
                    bool = false
                }
            }
        }
        else
        {
            bool = false
        }
        
        
        if bool == true
        {
            signUp()
        }
        else
        {
            if(years < 100)
            {
                displayAlert("Not Old Enough", message:"You need to be at least 13 years old to sign up")
            }
            else
            {
                displayAlert("Too Old", message:"Aren't you dead already?")
            }
        }
    }
    
    
    func getDate() -> String
    {
        return dateLabel.text!
    }
    
    func dateDidChange(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        dateFormatter.timeStyle = .NoStyle
        let date = datePicker.date
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        dateLabel.text = dateFormatter.stringFromDate(date)

    }
    
    @IBAction func signUp()
    {
        //ignore user events till sign up is performed
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0,0,50,50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        let user = PFUser()
        
        user.username = email
        user.password = password
        user["dob"] = getDate()
        user["name"] = name
        user["gender"] = genderSetGet
        
        print(name)
        print(email)
        print(password)
        print(getDate())
        //NSJSONReadingOptions.AllowFragments
        //Sign up in background
        user.signUpInBackgroundWithBlock({ (success, error) -> Void in
            self.activityIndicator.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            
            if error == nil {
                
                //signup success!
                print("done signup")
                //logged in
                let storyboard = UIStoryboard(name: "GroupVC", bundle: nil)
                let controller = storyboard.instantiateViewControllerWithIdentifier("GroupVCID") as UIViewController
                self.presentViewController(controller, animated: true, completion: nil)
                
            } else {
                self.displayAlert("Failed Signup", message: "\(error) \(error?.userInfo)")
            }
        })
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonClicked(sender:UIButton)
    {
        dispatch_async(dispatch_get_main_queue(), {
            
            if (sender == self.male)
            {
                if self.genderSetGet == true
                {
                    self.female.highlighted = false
                    sender.highlighted = true;
                }
                self.genderSetGet = false
            }
            if (sender == self.female)
            {
                if self.genderSetGet == false
                {
                    self.male.highlighted = false
                    sender.highlighted = true;
                }
                self.genderSetGet = true
            }
        });
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
