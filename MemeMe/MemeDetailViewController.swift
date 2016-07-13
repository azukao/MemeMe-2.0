//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Azuka Omesiete on 7/11/16.
//  Copyright © 2016 Azuka Omesiete. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    
        @IBOutlet weak var imageView: UIImageView!
        @IBOutlet weak var label: UILabel!
        
        var meme: Meme!
        
        override func viewWillAppear(animated: Bool) {
            super.viewWillAppear(animated)
            self.label.text = self.meme.topText
            
            self.tabBarController?.tabBar.hidden = true
            
            self.imageView!.image = meme.memeImage
        }
        
        override func viewWillDisappear(animated: Bool) {
            super.viewWillDisappear(animated)
            self.tabBarController?.tabBar.hidden = false
        }


}
