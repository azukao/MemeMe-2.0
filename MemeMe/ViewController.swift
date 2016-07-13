//
//  ViewController.swift
//  MemeMe
//
//  Created by Azuka Omesiete on 7/5/16.
//  Copyright © 2016 Azuka Omesiete. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIButton!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var buttomTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: 3.0]
    
    /*   struct Meme {
     var topText: String
     var bottomText: String
     var blankImage: UIImage
     var memeImage: UIImage
     }
     */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set Delegates for text field's attributes
        self.applyTextFieldAttributes(topTextField)
        self.applyTextFieldAttributes(buttomTextField)
        topTextField.delegate = self
        buttomTextField.delegate = self
        //Keep the share Button disabled till image is picked
        shareButton.enabled = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //Option to only enable camera when available
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        self.subscribeToKeyboardNotifications()
        self.generateMemedImage()
    }
    
    override func viewDidAppear(animated: Bool) {
        let nav = self.navigationController?.navigationBar
        // 2
        nav?.barStyle = UIBarStyle.Black
        nav?.tintColor = UIColor.yellowColor()
        // 3
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .ScaleAspectFit
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotification()
    }
    
    @IBAction func PickAnImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        // if image from photoroll
        if sender as! NSObject == cameraButton {
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        }
        if sender as! NSObject == albumButton {
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        presentViewController(imagePicker, animated: true, completion: nil)
        shareButton.enabled = true
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        let selectedImage : UIImage = image
        imagePickerView.image = selectedImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func applyTextFieldAttributes(textField: UITextField){
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName :  UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -7.0
        ]
        textField.defaultTextAttributes     = memeTextAttributes
    }
    
    
    // use this delegate to make keyboard dissappear after typing
    func textFieldShouldReturn(textfield: UITextField) -> Bool {
        textfield.resignFirstResponder()
        return true;
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as!NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if buttomTextField.isFirstResponder() {
            self.view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    // writing the method to hide keyboard
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    //  set method to subscribe keyboard
    func subscribeToKeyboardNotifications()  {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    //set unsubscribe method for keyboard
    func unsubscribeFromKeyboardNotification() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func generateMemedImage() -> UIImage
    {   //hide navigation and tool bar
        navigationController?.navigationBarHidden = true
        navigationController?.setToolbarHidden(true, animated: false)
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage =
            UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //shoe navigation and toolbar
        navigationController?.navigationBarHidden = false
        navigationController?.setToolbarHidden(false, animated: false)
        return memedImage
    }
    
    func save(memedImage: UIImage) {  //creating a finished meme
        let meme = Meme(topText: topTextField.text!, bottomText: buttomTextField.text!, blankImage: imagePickerView.image!, memeImage: memedImage)
        
        //add meme to array in app delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
    }
    
    @IBAction func share(sender: AnyObject) {
        var imageGoingIn: UIImage
        imageGoingIn = generateMemedImage()
        
        let controller = UIActivityViewController(activityItems: [imageGoingIn], applicationActivities: nil)
        
        presentViewController(controller, animated: true, completion: nil)
        controller.completionWithItemsHandler = { (activityType: String?, completed: Bool, returnedItems: [AnyObject]?, activityError: NSError?) in
            if completed {
                self.save(imageGoingIn)
                controller.dismissViewControllerAnimated(true, completion: nil)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
        
        
    }
    
    
    
    
    
    
}

