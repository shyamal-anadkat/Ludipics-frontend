//
//  cell.swift
//  ParseStarterProject-Swift
//
//  Created by Shyamal Anadkat on 2016-03-21.
//  Copyright © 2016 Ludipics LLC. All rights reserved.
//

import UIKit
import Parse

//this represents an individual cell on the connect scene
class cell: UITableViewCell {
    
    //for objects in the cell
    @IBOutlet var postedImage: UIImageView!
    @IBOutlet var username: UILabel!
    @IBOutlet var message: UILabel!
}
