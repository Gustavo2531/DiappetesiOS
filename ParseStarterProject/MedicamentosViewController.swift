//
//  MedicamentosViewController.swift
//  Diappetes
//
//  Created by Gustavo Méndez on 10/02/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse
class MedicamentosViewController: UIViewController {
    @IBOutlet weak var medicamento: UILabel!
    @IBOutlet weak var medicamento2: UILabel!
    @IBOutlet weak var medicamento3: UILabel!
    @IBOutlet weak var medicamento4: UILabel!
    @IBOutlet weak var medicamento5: UILabel!

    @IBOutlet weak var tiempo: UILabel!
    @IBOutlet weak var tiempo2: UILabel!
    @IBOutlet weak var tiempo3: UILabel!
    @IBOutlet weak var tiempo4: UILabel!
    @IBOutlet weak var tiempo5: UILabel!
    
    var tiempoString = ""
    var tiempoString2 = ""
    var tiempoString3 = ""
    var tiempoString4 = ""
    var tiempoString5 = ""
    
    override func viewDidLoad() {
        self.medicamento.text=""
        self.medicamento2.text=""
        self.medicamento3.text=""
        self.medicamento4.text=""
        self.medicamento5.text=""
        self.tiempo.text=""
        self.tiempo2.text=""
        self.tiempo3.text=""
        self.tiempo4.text=""
        self.tiempo5.text=""
        super.viewDidLoad()
        self.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.red], for:.selected)
        obtainDatos()
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
    
    func obtainDatos(){
        let query = PFQuery(className:"Recetas")
        query.whereKey("userId", equalTo: (PFUser.current()?.objectId)!)
        query.order(byDescending: "createdAt");
        query.getFirstObjectInBackground(block: {(object, error)
            in
            if error != nil{
                self.medicamento.text=""
                self.medicamento2.text=""
                self.medicamento3.text=""
                self.medicamento4.text=""
                self.medicamento5.text=""
                self.tiempo.text=""
                self.tiempo2.text=""
                self.tiempo3.text=""
                self.tiempo4.text=""
                self.tiempo5.text=""
                print(error!)
            }else{
                
                
                if ((object?["Medicamento4"] as AnyObject).description) != "" {
                    self.tiempoString4 = "Cada "+((object?["HoraMedicamento4"] as AnyObject).description)+" Hora por "+((object?["DiaMedicamento4"] as AnyObject).description)+" dia/s"
                    self.medicamento4.text=((object?["Medicamento4"] as AnyObject).description)+" mg"
                }
                if ((object?["Medicamento2"] as AnyObject).description) != "" {
                    self.tiempoString2 = "Cada "+((object?["HoraMedicamento2"] as AnyObject).description)+" Hora por "+((object?["DiaMedicamento2"] as AnyObject).description)+" dia/s"
                    self.medicamento2.text=((object?["Medicamento2"] as AnyObject).description)+" mg"
                }
                if ((object?["Medicamento3"] as AnyObject).description) != "" {
                    self.tiempoString3 = "Cada "+((object?["HoraMedicamento3"] as AnyObject).description)+" Hora por "+((object?["DiaMedicamento3"] as AnyObject).description)+" dia/s"
                    self.medicamento3.text=((object?["Medicamento3"] as AnyObject).description)+" mg"
                }
                if ((object?["Medicamento5"] as AnyObject).description) != "" {
                    self.tiempoString5 = "Cada "+((object?["HoraMedicamento5"] as AnyObject).description)+" Hora por "+((object?["DiaMedicamento5"] as AnyObject).description)+" dia/s"
                    self.medicamento5.text=((object?["Medicamento5"] as AnyObject).description)+" mg"
                }
                if ((object?["Medicamento1"] as AnyObject).description) != "" {
                    self.tiempoString = "Cada "+((object?["HoraMedicamento1"] as AnyObject).description)+" Hora por "+((object?["DiaMedicamento1"] as AnyObject).description)+" dia/s"
                    self.medicamento.text=((object?["Medicamento1"] as AnyObject).description)+" mg"
                }
                
                
                
                
                
                
                self.tiempo.text=self.tiempoString
                self.tiempo2.text=self.tiempoString2
                self.tiempo3.text=self.tiempoString3
                self.tiempo4.text=self.tiempoString4
                self.tiempo5.text=self.tiempoString5
            }
            
        })
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
