//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Azuka Omesiete on 7/11/16.
//  Copyright © 2016 Azuka Omesiete. All rights reserved.
//
import Foundation
import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    

    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    
    // Numbers of Items in section
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        
        return appDelegate.memes.count
    }
    
    
    //Cell for Item at indexPath
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        let meme = appDelegate.memes[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        
        cell.MemeImageView?.image = meme.memeImage
        cell.nameLabel.text = meme.topText
       
        
        return cell
    }
    
    //Did select item at index path
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        let meme = appDelegate.memes[indexPath.row]
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = meme
        
        self.navigationController!.pushViewController(detailController, animated: true)
  
    }

    

}
