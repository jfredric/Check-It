//
//  Utility.swift
//  To Do List
//
//  Created by Joshua Fredrickson on 9/28/17.
//  Copyright © 2017 Joshua Fredrickson. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    
    static func topViewController(base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
}

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

// send user a message
func messageAlert(title: String, message: String?, from: UIViewController?) {
    
    // Create the Alert Controller
    let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    // add the button actions - Left to right
    //    OK Button
    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    
    // Present the Alert
    
    (from ?? UIApplication.topViewController()!).present(alertController, animated: true, completion: nil)
}
