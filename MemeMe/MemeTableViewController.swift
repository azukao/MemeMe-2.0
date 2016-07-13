//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Azuka Omesiete on 7/11/16.
//  Copyright © 2016 Azuka Omesiete. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var memes:[Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
 
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView!.reloadData()
        
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        
        return appDelegate.memes.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        let meme = appDelegate.memes[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableViewCell", forIndexPath: indexPath) as! MemeTableViewCell
        cell.memeText?.text = meme.topText
        cell.memeImageView?.image = meme.memeImage
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        let meme = appDelegate.memes[indexPath.row]
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = meme
        
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    


    

    


}
