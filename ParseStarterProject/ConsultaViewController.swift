//
//  ConsultaViewController.swift
//  Diappetes
//
//  Created by Admin on 20/06/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
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
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "fondo4.png")
        self.view.insertSubview(backgroundImage, at: 0)
        
        self.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.red], for:.selected)

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
                
                
                self.datePicker.setDate(Date(), animated: true)
                
                
            }else{
                self.displayAlert("Could Not Save Date", message: "Cambia la fecha")
            }
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
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
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
