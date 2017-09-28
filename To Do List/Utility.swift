//
//  Utility.swift
//  To Do List
//
//  Created by Joshua Fredrickson on 9/28/17.
//  Copyright © 2017 Joshua Fredrickson. All rights reserved.
//

import Foundation
import UIKit

func confirmAlert(message: String?, from: UIViewController, forYes: ((UIAlertAction) -> Void)? = nil) {
    
    // Create the Alert Controller
    let alertController = UIAlertController(title: "Confirm", message: message, preferredStyle: UIAlertControllerStyle.alert)
    // add the button actions - Left to right
    //    Cancel Button
    alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default,handler: nil))
    //    OK Button
    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: forYes))
    
    // Present the Alert
    print("Confirming: \(message!)")
    from.present(alertController, animated: true, completion: nil)
}
