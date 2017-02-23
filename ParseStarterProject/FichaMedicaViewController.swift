//
//  FichaMedicaViewController.swift
//  Diappetes
//
//  Created by Gustavo Méndez on 10/02/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse
class FichaMedicaViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var glucosaPicker: UIPickerView!
    var pickerDataSource = [0.0];
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func displayAlert(_ title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction((UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            
            self.dismiss(animated: true, completion: nil)
            
        })))
        //print("Llegaste aqui???")
        
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    func dataSources(){
        
        var i = pickerDataSource[0]
        
        while i <= 600{
            
            //print(i * 5)
            i=i+0.10
            i = Double(round(100*i)/100)
            
            pickerDataSource.append(i)
            
        }
        
    }
    override func viewDidLoad() {
        dataSources()
        super.viewDidLoad()
        self.glucosaPicker.dataSource = self;
        self.glucosaPicker.delegate = self;
        self.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.red], for:.selected)
        self.glucosaPicker.selectRow( pickerDataSource.index(of: 200.0)!, inComponent: 0, animated: true)
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func ingresarDatos(_ sender: Any) {
        
        activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
        activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        let glucose = PFObject(className: "GlucosePostrPrandial")
        //var dateFormatter = NSDateFormatter()
        
        
        
        glucose["date"] = datePicker.date
        glucose["userId"] =  PFUser.current()?.objectId
        glucose["quantity"] = Double(pickerDataSource[glucosaPicker.selectedRow(inComponent: 0)])
        
        
      
        glucose.saveInBackground{(save,error) -> Void in
            
            self.activityIndicator.stopAnimating()
            
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if error ==  nil{
                if(Double(self.pickerDataSource[self.glucosaPicker.selectedRow(inComponent: 0)]) > 220){
                    self.displayAlert("Glucosa Registrada", message: "Tu bitacora ha sido salvada exitosamente, pero cuidado tienes la glucosa")
                }else{
                    self.displayAlert("Glucosa Registrada", message: "Tu bitacora ha sido salvada exitosamente")}
                
                
                self.datePicker.setDate(Date(), animated: true)
                
                
            }else{
                self.displayAlert("Fallo en el registro", message: "Por favor intentalo Otra vez")
            }
        }
        
        
    }

    @IBAction func returnMenu(_ sender: Any) {
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
       override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.tintColor = UIColor.red
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
