//
//  AddEventVC.swift
//  Diappetes
//
//  Created by Gustavo Méndez on 15/02/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import EventKit

class AddEventVC: UIViewController {
    
    @IBOutlet weak var txtEventName: UITextField!
    @IBOutlet weak var txtStartDate: UITextField!
    @IBOutlet weak var txtEndDate: UITextField!
    
    let datePicker: UIDatePicker = UIDatePicker()
    let eventStore = EKEventStore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupDatePicker()
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
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AddEventVC.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(AddEventVC.cancelClick))
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
    
    
    @IBAction func actionAddEvent(_ sender: AnyObject) {
        if txtStartDate.text == "" || txtEndDate.text == "" || txtEventName.text == "" {
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = setDateFormat
        let dateStart = dateFormatter.date(from: (txtStartDate.text)!)
        let dateEnd = dateFormatter.date(from: (txtEndDate.text)!)
        
        let event:EKEvent = EKEvent(eventStore: eventStore)
        event.title = txtEventName.text!
        event.startDate = dateStart!
        event.endDate = dateEnd!
        event.notes = "This is a note"
        event.addAlarm(EKAlarm.init(relativeOffset: -300.0))
        event.addAlarm(EKAlarm(absoluteDate: event.startDate))
        event.calendar = eventStore.defaultCalendarForNewEvents
        
        do {
            try eventStore.save(event, span: .thisEvent)
            print("events added with dates:")
            self.actionBack(sender)
        } catch let e as NSError {
            print(e.description)
            return
        }
        print("Saved Event")
        
    }
    
    @IBAction func actionBack(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
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
