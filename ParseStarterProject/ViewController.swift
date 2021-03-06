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
import ParseTwitterUtils

class ViewController: UIViewController, UITextFieldDelegate {
    
    var signupActive = true
    
    @IBOutlet var username: UITextField!
    
    @IBOutlet var password: UITextField!
    
    @IBOutlet var signupButton: UIButton!
    
    @IBOutlet var registeredText: UILabel!
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet weak var loginButton2: UIButton!
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
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
    @IBAction func twitterLogin(_ sender: Any) {
//        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//        activityIndicator.center = self.view.center
//        activityIndicator.hidesWhenStopped = true
//        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
//        view.addSubview(activityIndicator)
//        activityIndicator.startAnimating()
//        UIApplication.shared.beginIgnoringInteractionEvents()

         var errorMessage = "Please try again later"
        PFTwitterUtils.logIn { (user, error) -> Void in
            let pftwitter=PFTwitterUtils.twitter()
            var h = PFUser()
            h.username = pftwitter?.screenName
            print(pftwitter?.screenName)
            h.password = (pftwitter?.screenName)! + "1"
            h["isDoctor"] = false
            h["name"] = pftwitter?.screenName
            h["apellido"] = pftwitter?.screenName
            h.signUpInBackground(block: { (success, error) -> Void in
//
                self.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
                if error == nil {
                    
                    // Signup successful
                    
                    self.performSegue(withIdentifier: "login", sender: self)
                    
                    
                } else {
                    PFUser.logInWithUsername(inBackground: (pftwitter?.screenName)!, password: (pftwitter?.screenName)! + "1", block: { (user1, error) -> Void in
                        
                        self.activityIndicator.stopAnimating()
                        UIApplication.shared.endIgnoringInteractionEvents()
                        
                        if user1 != nil {
                            
                            // Logged In!
                            
                            self.performSegue(withIdentifier: "login", sender: self)
                            
                            
                        } else {
                            
                            if let errorString = (error! as NSError).userInfo["error"] as? String{
                                
                                errorMessage = errorString
                                
                            }
                            
                            self.displayAlert("Failed Login", message: errorMessage)
                            
                        }
                        
                    })

                    if let errorString = (error! as NSError).userInfo["error"] as? String {
                        
                        errorMessage = errorString
                        
                    }
                    
                    self.displayAlert("Failed SignUp", message: errorMessage)
                    
                }
                
            })

        }
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
                user["isDoctor"] = false
                user["name"] = name.text
                user["apellido"] = lastName.text
                
                
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
    
    @IBAction func backgroundTap(sender: UIControl) {
        username.resignFirstResponder()
        password.resignFirstResponder()
        name.resignFirstResponder()
        lastName.resignFirstResponder()
        
    }
    
    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func logIn(_ sender: AnyObject) {
        
        if signupActive == true {
            
            signupButton.setTitle("Log In", for: UIControlState())
            
            registeredText.text = "Not registered?"
            
            loginButton.setTitle("Sign Up", for: UIControlState())
            
            signupActive = false
            name.isHidden = true
            lastName.isHidden = true
            signupButton.isHidden=true
            loginButton2.isHidden = false
            
        } else {
            
            signupButton.setTitle("Sign Up", for: UIControlState())
            
            registeredText.text = "Already registered?"
            
            loginButton.setTitle("Login", for: UIControlState())
            
            signupActive = true
            name.isHidden = false
            lastName.isHidden = false
            loginButton2.isHidden = true
            signupButton.isHidden=false
            
        }
        
        
    }
    
    override func viewDidLoad() {
        loginButton2.isHidden = true

        super.viewDidLoad()
        username.delegate=self
        password.delegate=self
        
        name.delegate=self
        lastName.delegate=self
        
        
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
