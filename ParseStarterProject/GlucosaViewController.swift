//
//  GlucosaViewController.swift
//  Diappetes
//
//  Created by Admin on 20/06/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class GlucosaViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //private let pickerViewData = Array(0...600)     // contents will be 0, 1, 2, 3...59, change to whatever you want
    //private let pickerViewRows = 100_000
    
   // private let pickerViewMiddle = ((pickerViewRows / pickerViewData.count) / 2) * pickerViewData.count
    var pickerDataSource = [0.0];
    
    
    
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var pickerView: UIPickerView!
    
    @IBOutlet var labelGlucose: UILabel!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func displayAlert(_ title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction((UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            
            self.dismiss(animated: true, completion: nil)
            
        })))
        //print("Llegaste aqui???")
        
      
        self.present(alert, animated: true, completion: nil)
        
        
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
        
        
        let glucose = PFObject(className: "Glucose")
        //var dateFormatter = NSDateFormatter()
        
        
        
        glucose["date"] = datePicker.date
        glucose["userId"] =  PFUser.current()?.objectId
        glucose["quantity"] = Double(pickerDataSource[pickerView.selectedRow(inComponent: 0)])
        
    
        if(Double(pickerDataSource[pickerView.selectedRow(inComponent: 0)]) > 180){
            labelGlucose.text = "Cuidate tienes la glucosa alta"
        }
       glucose.saveInBackground{(save,error) -> Void in
            
           self.activityIndicator.stopAnimating()
            
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if error ==  nil{
                
                self.displayAlert("Glucose Saved", message: "Your data has been saved successfully")
                
                
                self.datePicker.setDate(Date(), animated: true)
                
                
            }else{
                self.displayAlert("Could Not Save Data", message: "Please Try Again")
            }
        }
        
        
        
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
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "iOS-7-Wallpaper-2-577x1024.png")!)
        
        self.pickerView.selectRow( pickerDataSource.index(of: 100.0)!, inComponent: 0, animated: true)

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
