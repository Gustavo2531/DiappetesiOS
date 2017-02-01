/**
 * Copyright (c) 2015-present, Parse, LLC.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    var signupActive = true
    
    @IBOutlet var username: UITextField!
    
    @IBOutlet var password: UITextField!
    
    @IBOutlet var signupButton: UIButton!
    
    @IBOutlet var registeredText: UILabel!
    
    @IBOutlet var loginButton: UIButton!
    
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func displayAlert(_ title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction((UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            
            self.dismiss(animated: true, completion: nil)
            
        })))
        //print("Llegaste aqui???")
        
        DispatchQueue.main.async(execute: {
            self.presentViewController(alert, animated: true, completion: nil)
        })
        //self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func signUp(_ sender: AnyObject) {
        
        if username.text == "" || password.text == "" {
            
           displayAlert("Error in form", message: "Please enter a username and password")
            
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            var errorMessage = "Please try again later"
            
            if signupActive == true {
                
                var user = PFUser()
                user.username = username.text
                user.password = password.text
                
                
                
                user.signUpInBackground(block: { (success, error) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if error == nil {
                        
                        // Signup successful
                        
                        self.performSegue(withIdentifier: "login", sender: self)
                        
                        
                    } else {
                        
                        if let errorString = (error! as NSError).userInfo["error"] as? String {
                            
                            errorMessage = errorString
                            
                        }
                        
                       self.displayAlert("Failed SignUp", message: errorMessage)
                        
                    }
                    
                })
                
            } else {
                
                PFUser.logInWithUsername(inBackground: username.text!, password: password.text!, block: { (user, error) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if user != nil {
                        
                        // Logged In!
                        
                        self.performSegue(withIdentifier: "login", sender: self)
                        
                        
                    } else {
                        
                        if let errorString = (error! as NSError).userInfo["error"] as? String{
                            
                            errorMessage = errorString
                            
                        }
                        
                        self.displayAlert("Failed Login", message: errorMessage)
                        
                    }
                    
                })
                
            }
            
        }
        
        
        
    }
    
    
    @IBAction func logIn(_ sender: AnyObject) {
        
        if signupActive == true {
            
            signupButton.setTitle("Log In", for: UIControlState())
            
            registeredText.text = "Not registered?"
            
            loginButton.setTitle("Sign Up", for: UIControlState())
            
            signupActive = false
            
        } else {
            
            signupButton.setTitle("Sign Up", for: UIControlState())
            
            registeredText.text = "Already registered?"
            
            loginButton.setTitle("Login", for: UIControlState())
            
            signupActive = true
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "iOS-7-Wallpaper-2-577x1024.png")!)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if PFUser.current()?.objectId != nil {
            
            self.performSegue(withIdentifier: "login", sender: self)
            
        }        
    }
    
    fileprivate func presentViewController(_ alert: UIAlertController, animated flag: Bool, completion: (() -> Void)?) -> Void {
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: flag, completion: completion)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
