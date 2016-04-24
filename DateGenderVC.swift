//
//  DateGenderVC.swift
//  LudipicsUpdated
//
//  Created by Akshansh Thakur on 4/23/16.
//  Copyright © 2016 Akshansh Thakur. All rights reserved.
//

import UIKit

class DateGenderVC: UIViewController, UITextFieldDelegate {

    
    var Gender: Bool = true
    
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
    
    
    
    @IBAction func maleButton(sender: UIButton) {
        genderSetGet = false
    }
    
    
    @IBAction func femaleButton(sender: UIButton) {
        genderSetGet = true
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = UIDatePickerMode.Date
        
        datePicker.addTarget(self, action: #selector(DateGenderVC.dateDidChange(_:)), forControlEvents: .ValueChanged)
        // Do any additional setup after loading the view.
        

    }
    
    func dateDidChange(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        dateFormatter.timeStyle = .NoStyle
        let date = datePicker.date
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        dateLabel.text = dateFormatter.stringFromDate(date)

    }
    
   
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
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
