//
//  SignosVitalesViewController.swift
//  Diappetes
//
//  Created by Gustavo Méndez on 22/02/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse


class SignosVitalesViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    var pickerDataSourceAyuno = [126.0];
    var pickerDataSourcePostPrandial = [200.0];
    var pickerDataSourceCalorias = [2000.0];

    @IBOutlet weak var maxGluAyun: UIPickerView!
    
    @IBOutlet weak var maxGluPost: UIPickerView!
    
    @IBOutlet weak var maxCalSem: UIPickerView!


    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func displayAlert(_ title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction((UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            
            self.dismiss(animated: true, completion: nil)
            
        })))
        //print("Llegaste aqui???")
        
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func guardarDatos(_ sender: Any) {
        activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
        activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        let signosVitales = PFObject(className: "SignosVitales")
        //var dateFormatter = NSDateFormatter()
        
        
        
        signosVitales["userId"] =  PFUser.current()?.objectId
        signosVitales["maxGluAyun"] = Double(pickerDataSourceAyuno[maxGluAyun.selectedRow(inComponent: 0)])
        signosVitales["maxGluPost"] = Double(pickerDataSourcePostPrandial[maxGluPost.selectedRow(inComponent: 0)])
        signosVitales["maxCalSem"] = Double(pickerDataSourceCalorias[maxCalSem.selectedRow(inComponent: 0)])

        signosVitales.saveInBackground{(save,error) -> Void in
            
            self.activityIndicator.stopAnimating()
            
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if error ==  nil{
                
                self.displayAlert("Signos Vitales Salvado", message: "Los datos fueron salvados")
                
                
            }else{
                self.displayAlert("No se salvo", message: "Por favor intenta otra vez")
            }
        }

    }
    func dataSources(){
        
        var i = pickerDataSourceAyuno[0]
        var n = pickerDataSourcePostPrandial[0]
        var z = pickerDataSourceCalorias[0]
        while i <= 250{
            
            //print(i * 5)
            i=i+0.10
            i = Double(round(100*i)/100)
            
            pickerDataSourceAyuno.append(i)
            
        }
        
        while n <= 300{
            
            //print(i * 5)
            n=n+0.10
            n = Double(round(100*n)/100)
            
            pickerDataSourcePostPrandial.append(n)
            
        }
        
        while z <= 10000{
            
            //print(i * 5)
            z=z+1
            z = Double(round(100*z)/100)
            
            pickerDataSourceCalorias.append(z)
            
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
        if (pickerView.tag==1){
            return pickerDataSourceAyuno.count;
        }else if (pickerView.tag==2){
            return pickerDataSourcePostPrandial.count;
        }else{
            return pickerDataSourceCalorias.count;
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        
        if (pickerView.tag==1){
            return String(pickerDataSourceAyuno[row])

        }else if (pickerView.tag==2){
            return String(pickerDataSourcePostPrandial[row])
        }else{
            return String(pickerDataSourceCalorias[row])
        }
    }
    
    override func viewDidLoad() {
        dataSources()
        super.viewDidLoad()
        
        self.maxGluAyun.dataSource = self;
        self.maxGluAyun.delegate = self;
        self.maxGluAyun.selectRow( pickerDataSourceAyuno.index(of: 126.0)!, inComponent: 0, animated: true)
        self.maxGluPost.dataSource = self;
        self.maxGluPost.delegate = self;
        self.maxGluPost.selectRow( pickerDataSourcePostPrandial.index(of: 200.0)!, inComponent: 0, animated: true)
        self.maxCalSem.dataSource = self;
        self.maxCalSem.delegate = self;
        self.maxCalSem.selectRow( pickerDataSourceCalorias.index(of: 2000.0)!, inComponent: 0, animated: true)
        
        // Do any additional setup after loading the view.
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
