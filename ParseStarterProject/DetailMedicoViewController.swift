//
//  DetailMedicoViewController.swift
//  Diappetes
//
//  Created by Gustavo Méndez on 01/03/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit

class DetailMedicoViewController: UIViewController {
    @IBOutlet weak var nombreText: UILabel!
    @IBOutlet weak var direccionText: UILabel!
    var direccion = "String"
    var nombre = "String"
    var apellido="String"
    var userName="String"
    override func viewDidLoad() {
        super.viewDidLoad()
        nombreText.text=nombre
        direccionText.text=direccion
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cita"{
            let sigVista=segue.destination as! ConsultaViewController
            sigVista.apellido=apellido
            sigVista.userName=userName
        }else{
        
            let sigVista=segue.destination as! PhotoViewController
            
            sigVista.userName=userName
        }
       
        
        
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
