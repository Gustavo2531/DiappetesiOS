//
//  PhotoViewController.swift
//  Diappetes
//
//  Created by Gustavo Méndez on 14/04/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse
class PhotoViewController:UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var userName="username"
    @IBOutlet weak var numero: UITextField!
    @IBOutlet weak var imagenVista: UIImageView!
    @IBOutlet weak var rolloBoton: UIButton!
    @IBOutlet weak var camaraBoton: UIButton!
     var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var image:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            camaraBoton.isHidden = false
            rolloBoton.isHidden = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateDisplay()
    }
    func displayAlert(_ title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction((UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            
            self.dismiss(animated: true, completion: nil)
            
        })))
        //print("Llegaste aqui???")
        
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    func updateDisplay(){
        imagenVista.image = image
    }
    
    @IBAction func album() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func camara(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        if (sender == camaraBoton) {
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraDevice = UIImagePickerControllerCameraDevice.front
        } else {
            picker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
        }
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
        self.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
  
    
 
    
    @IBAction func saveAlbum(_ sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(imagenVista.image!, nil, nil, nil)
        let alertView = UIAlertView(title: "Imagen", message: "Imagen Guardada", delegate: nil, cancelButtonTitle: "OK")
        alertView.show()
    }
   
    
    @IBAction func ingresarDatos(_ sender: AnyObject) {
        activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
        activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        let post = PFObject(className: "Post")
        
        
        post["userId"] =  PFUser.current()?.objectId
        
        post["drusername"] = userName
        
        let imageData = UIImageJPEGRepresentation( imagenVista.image!, 0.5)
        
        let imageFile = PFFile(name: "image.jpg", data: imageData!)
        
        post["imageFile"] = imageFile
        
        post.saveInBackground{(save,error) -> Void in
            
            self.activityIndicator.stopAnimating()
            
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if error ==  nil{
                
                self.displayAlert("Image Posted", message: "Your image has been posted successfully")
                
                self.imagenVista.image = UIImage(named: "image.jpg")
                
                
                
                
            }else{
                self.displayAlert("Could Not Post Image", message: "Please Try Again")
            }
        }
 
        
    }
    
    @IBAction func pruebaSwipe(_ sender: UISwipeGestureRecognizer) {
        
        if (self.image != nil){
        
        activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
        activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        let post = PFObject(className: "Post")
        
        
        post["userId"] =  PFUser.current()?.objectId
        
        post["drusername"] = userName
        
        let imageData = UIImageJPEGRepresentation( imagenVista.image!, 0.5)
        
        let imageFile = PFFile(name: "image.jpg", data: imageData!)
        
        post["imageFile"] = imageFile
        
        post.saveInBackground{(save,error) -> Void in
            
            self.activityIndicator.stopAnimating()
            
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if error ==  nil{
                
                self.displayAlert("Image Posted", message: "Your image has been posted successfully")
                
                self.imagenVista.image = UIImage(named: "image.jpg")
                
                
                
                
            }else{
                self.displayAlert("Could Not Post Image", message: "Please Try Again")
            }
        }

    }
    }
    
}

