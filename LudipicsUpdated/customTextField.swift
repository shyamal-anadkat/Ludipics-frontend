//
//  customTextField.swift
//  LudipicsUpdated
//
//  Copyright © 2016 Ludipics. All rights reserved.
//

import UIKit

class customTextField: UITextField {
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: bounds.origin.x + 12.0, y: bounds.origin.y), size: bounds.size)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: bounds.origin.x + 12.0, y: bounds.origin.y), size: bounds.size)
    }
    
    override func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: bounds.origin.x + 12.0, y: bounds.origin.y), size: bounds.size)
    }
    
}