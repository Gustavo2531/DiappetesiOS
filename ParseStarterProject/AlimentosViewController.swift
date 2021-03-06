//
//  AlimentosViewController.swift
//  Diappetes
//
//  Created by Admin on 20/06/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class PruebasAlimento:NSObject{
    func agregarAlimento(x:Int, cal:Double, cant :Double)->Double{
        var resultado = 0.0
        switch x {
        case 0:
            resultado = cal * cant
            
        case 1:
            resultado = cal * cant
        case 2:
            resultado = cal * cant * 1000
            
        case 3:
            resultado = cal * (cant/10)
        default:
            print("Something else")
        }
        return resultado
        
    }
    func porDos(_ x:Int)->Int{
        return x*2
    }
}

class AlimentosViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate  {
    var foodDataSource = ["Platano","Carne","Atún","Ensalada","Pollo","Pescado","Manzana","Mango","Jamón","Sandwich","Cereal","Barbacoa","Refresco"];
    var quantityDataSource = ["ml","gr","kg","pedazos"];
    
    var nameFood="";
    var calorias=0.0;
    var quantityFood = 0.0
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var pickerQuantityView: UIPickerView!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func displayAlert(_ title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction((UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            
            self.dismiss(animated: true, completion: nil)
            
        })))
        //print("Llegaste aqui???")
        
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func backgroundTap(sender: UIControl) {
        textField.resignFirstResponder()
        
    }
    
    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }
    

    func agregarAlimento() {
        
        
        let caso=pickerQuantityView.selectedRow(inComponent: 0)
        let cal = self.calorias
        
        let cantidadPreeliminar = Double(textField.text!)
        let r = PruebasAlimento()
        
        self.quantityFood = r.agregarAlimento(x: caso, cal: cal, cant: cantidadPreeliminar!)
        //        switch pickerQuantityView.selectedRow(inComponent: 0) {
        //        case 0:
        //            self.quantityFood = self.calorias * Double(textField.text!)!
        //
        //        case 1:
        //             self.quantityFood = self.calorias * Double(textField.text!)!
        //        case 2:
        //            self.quantityFood = self.calorias * Double(textField.text!)!*1000
        //
        //        case 3:
        //              self.quantityFood = self.calorias * (Double(textField.text!)!/10)
        //        default:
        //            print("Something else")
        //        }
        //
        print(quantityFood)
        //food["quantityFood"] = Double(quantityDataSource[pickerQuantityView.selectedRowInComponent(0)])
    }
    @IBAction func ingresarAlimentos(_ sender: AnyObject) {
        agregarAlimento()
        activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
        activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        let food = PFObject(className: "Food")
        //var dateFormatter = NSDateFormatter()
        
        food["food"] = nameFood
        
        food["date"] = Date()
        food["userId"] =  PFUser.current()?.objectId
        
        
        food["quantity"] = quantityFood
        
        
        food.saveInBackground{(save,error) -> Void in
            
            self.activityIndicator.stopAnimating()
            
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if error ==  nil{
                
                self.displayAlert("Alimentos Salvados", message: "Tu ingesta de hoy ha sdo salvada")
                
                
                self.textField.text = "0"
                
                
            }else{
                self.displayAlert("No se puedo salvar", message: "Please Try Again")
            }
        }
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        labelName.text=nameFood
        self.pickerQuantityView.dataSource = self;
        self.pickerQuantityView.delegate = self;
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var h = 0
        
        
        if pickerView.tag == 2{
            h = quantityDataSource.count
        }
        return h;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        var h = ""
        
        if pickerView.tag == 2{
            h = quantityDataSource[row]
        }
        return h
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
