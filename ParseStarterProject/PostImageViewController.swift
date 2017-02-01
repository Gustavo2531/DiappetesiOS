//
//  PostImageViewController.swift
//  InstagramClone
//
//  Created by Admin on 15/06/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
class PostImageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet var imageToBePost: UIImageView!
       @IBAction func chooseImage(_ sender: AnyObject) {
        
        let imageToPost = UIImagePickerController()
        imageToPost.delegate = self
        imageToPost.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imageToPost.allowsEditing = false
        self.present(imageToPost, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.dismiss(animated: true, completion: nil)
        
        imageToBePost.image = image
        
        
        
    }
    @IBOutlet var message: UITextField!
    
    
    @IBAction func postImage(_ sender: AnyObject) {
        
        activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
        activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        let post = PFObject(className: "Post")
        
        post["message"] = message.text
        
        post["usedId"] =  PFUser.current()?.objectId
    
        let imageData = UIImageJPEGRepresentation(imageToBePost.image!, 0.5)
        
        let imageFile = PFFile(name: "image.jpg", data: imageData!)
        
        post["imageFile"] = imageFile
        
        post.saveInBackground{(save,error) -> Void in
            
            self.activityIndicator.stopAnimating()
            
            UIApplication.shared.endIgnoringInteractionEvents()
         
            if error ==  nil{
                
                 self.displayAlert("Image Posted", message: "Your image has been posted successfully")
                
                self.imageToBePost.image = UIImage(named: "Man_Woman_Avatar-512.png")
                
                self.message.text = ""
               
                
            }else{
                 self.displayAlert("Could Not Post Image", message: "Please Try Again")
            }
        }
        
        
        
    }
    func displayAlert(_ title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction((UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            
            self.dismiss(animated: true, completion: nil)
            
        })))
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
