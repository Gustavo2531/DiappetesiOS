//
//  CalendarioViewController.swift
//  Diappetes
//
//  Created by Gustavo Méndez on 10/02/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import EventKit

var setDateFormat:String = "dd-MM-yyyy hh:mm a"
class CalendarioViewController: UIViewController {
    @IBOutlet weak var txtStartDate: UITextField!
    @IBOutlet weak var txtEndDate: UITextField!
    
    let datePicker: UIDatePicker = UIDatePicker()
    let eventStore = EKEventStore()
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "fondo4.png")
        self.view.insertSubview(backgroundImage, at: 0)
        self.SOGetPermissionCalendarAccess()
        self.setupDatePicker()

        // Do any additional setup after loading the view.
    }
    @IBAction func Calendario(_ sender: Any) {
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    
    //MARK: Get Premission for access Calender
    func SOGetPermissionCalendarAccess() {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            print("Authorised")
        case .denied:
            print("Access denied")
        case .notDetermined:
            // 3
            
            
            
            eventStore.requestAccess(to: .event, completion: { (granted: Bool, error: Error?) in
                if granted {
                    print("Granted")
                } else {
                    print("Access Denied")
                }
            } )
        default:
            print("Case Default")
        }
    }
    
    
    func setupDatePicker() {
        // Specifies intput type
        datePicker.datePickerMode = .dateAndTime
        
        // Creates the toolbar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adds the buttons
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(CalendarioViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(CalendarioViewController.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        // Adds the toolbar to the view
        txtStartDate!.inputView = datePicker
        txtStartDate!.inputAccessoryView = toolBar
        txtStartDate?.tag = 1
        
        txtEndDate!.inputView = datePicker
        txtEndDate!.inputAccessoryView = toolBar
        txtEndDate?.tag = 2
    }
    
    func doneClick() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = setDateFormat
        //dateFormatter.dateStyle = .ShortStyle
        if txtStartDate?.isFirstResponder == true {
            txtStartDate!.text = dateFormatter.string(from: datePicker.date)
            txtStartDate!.resignFirstResponder()
        } else {
            txtEndDate!.text = dateFormatter.string(from: datePicker.date)
            txtEndDate!.resignFirstResponder()
        }
    }
    
    func cancelClick() {
        txtStartDate!.resignFirstResponder()
        txtEndDate!.resignFirstResponder()
    }
    
    @IBAction func actionFetchEvent(_ sender: AnyObject) {
        if txtStartDate.text == "" || txtEndDate.text == "" {
            return
        }
        
        let objEvent = self.storyboard?.instantiateViewController(withIdentifier: "EventVCID") as! EventVC
        objEvent.startDate = txtStartDate.text!
        objEvent.endDate = txtEndDate.text!
        self.navigationController?.pushViewController(objEvent, animated: true)
    }
    
    @IBAction func actionNewEvent(_ sender: AnyObject) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
