//
//  imageDelegate.swift
//  MemeMe
//
//  Created by Azuka Omesiete on 7/5/16.
//  Copyright © 2016 Azuka Omesiete. All rights reserved.
//

import Foundation
import UIKit

class imageDelegate: UIViewController, UIImagePickerControllerDelegate {
    
    func pickAnImage(sender: AnyObject) {
        let pickController = UIImagePickerController()
        self.presentViewController(pickController, animated: true, completion: nil)
    }
    
    
}
