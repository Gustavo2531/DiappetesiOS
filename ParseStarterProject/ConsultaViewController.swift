//
//  ConsultaViewController.swift
//  Diappetes
//
//  Created by Admin on 20/06/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
import EventKit
class ConsultaViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate  {
    
    @IBAction func returnMenu(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    var pickerDataSource = ["Dra. Cortés","Dra. Camargo","Dra. Puerto","Dra. Zamora","Dr. Abdo","Dr. Orihuela"];
    
    
    
    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet var doctorPicker: UIPickerView!
    let eventStore = EKEventStore()
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func displayAlert(_ title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction((UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            
            self.dismiss(animated: true, completion: nil)
            
        })))
        //print("Llegaste aqui???")
        
        
        self.present(alert, animated: true, completion: nil)
        
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.doctorPicker.dataSource = self;
        self.doctorPicker.delegate = self;
                
        self.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.red], for:.selected)
        self.SOGetPermissionCalendarAccess()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.tintColor = UIColor.red
    }
    @IBAction func solicitarConsulta(_ sender: AnyObject) {
          //print(datePicker.datePickerMode())
       activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
        activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        let consulta = PFObject(className: "Consulta")
        //var dateFormatter = NSDateFormatter()
        
        
      
        consulta["date"] = datePicker.date
        consulta["userId"] =  PFUser.current()?.objectId
        consulta["doctor"] = pickerDataSource[doctorPicker.selectedRow(inComponent: 0)]
        
        
        
        consulta.saveInBackground{(save,error) -> Void in
            
            self.activityIndicator.stopAnimating()
            
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if error ==  nil{
                
                self.displayAlert("Your date was saved", message: "Tu consulta se programo")
                
                
                let dateStart = self.datePicker.date
                let dateEnd = self.datePicker.date.addingTimeInterval(5.0 * 60.0)
                
                let event:EKEvent = EKEvent(eventStore: self.eventStore)
                
                event.title = "Consulta con "+String(self.pickerDataSource[self.doctorPicker.selectedRow(inComponent: 0)])
                event.startDate = dateStart
                event.endDate = dateEnd
                event.notes = "Consulta"
                event.addAlarm(EKAlarm.init(relativeOffset: -1800.0))
                event.addAlarm(EKAlarm(absoluteDate: event.startDate))
                event.calendar = self.eventStore.defaultCalendarForNewEvents
                do{
                    try self.eventStore.save(event, span: .thisEvent)
                    print("events added with dates:")
                } catch let e as NSError {
                    print(e.description)
                    return
                }
                self.datePicker.setDate(Date(), animated: true)

                
                
            }else{
                self.displayAlert("Could Not Save Date", message: "Cambia la fecha")
            }
        }

        
    }
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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerDataSource[row])
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
