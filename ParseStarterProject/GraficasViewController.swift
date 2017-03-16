//
//  GraficasViewController.swift
//  Diappetes
//
//  Created by Gustavo Méndez on 10/02/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse
class GraficasViewController: UIViewController {
var caloriasSemanal=0.0
var caloriasHoy=0.0
var caloriasMensual=0.0
    
    
    @IBOutlet weak var caloriasHoyLabel: UILabel!
    @IBOutlet weak var caloriasSemanalLabel: UILabel!
    @IBOutlet weak var caloriasMonthLabel: UILabel!
    
    override func viewDidLoad() {
        obtainDatos()
        super.viewDidLoad()
        self.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.red], for:.selected)

        // Do any additional setup after loading the view.
    }
    func obtainDatos(){
        var calendar = NSCalendar.autoupdatingCurrent
        calendar.timeZone = NSTimeZone(forSecondsFromGMT: 0) as TimeZone
        
        let today = Date()
        let cal = Calendar(identifier: .gregorian)
        let newDate = cal.startOfDay(for: today)
        
        
        
        let tommorow = Calendar.current.date(byAdding: .day, value: 1, to: newDate)
    
        let query = PFQuery(className:"Food")
        query.whereKey("userId", equalTo: (PFUser.current()?.objectId)!)
        query.order(byDescending: "createdAt");
       
        query.whereKey("createdAt", greaterThanOrEqualTo: newDate)
        query.whereKey("createdAt", lessThan: tommorow!)
        
        query.findObjectsInBackground(block: { (objects, error) in
            if error != nil{
                print(error!)
            }else{
                for object in objects!{
                    
                    self.caloriasHoy=self.caloriasHoy+(object["quantity"] as! Double)
                    
                }
                self.caloriasHoyLabel.text=String(self.caloriasHoy)
                
            }
            
        })
        
        let week = Calendar.current.date(byAdding: .weekday, value: 1, to: newDate)
        
        let query2 = PFQuery(className:"Food")
        query2.whereKey("userId", equalTo: (PFUser.current()?.objectId)!)
        query2.order(byDescending: "createdAt");
        
        query2.whereKey("createdAt", greaterThanOrEqualTo: newDate)
        query2.whereKey("createdAt", lessThan: week!)
        
        query2.findObjectsInBackground(block: { (objects, error) in
            if error != nil{
                print(error!)
            }else{
                for object in objects!{
                    
                    self.caloriasSemanal=self.caloriasSemanal+(object["quantity"] as! Double)
                    
                }
                self.caloriasSemanalLabel.text=String(self.caloriasSemanal)
            }
            
        })
        
        let month = Calendar.current.date(byAdding: .month, value: 1, to: newDate)
        
        let query3 = PFQuery(className:"Food")
        query3.whereKey("userId", equalTo: (PFUser.current()?.objectId)!)
        query3.order(byDescending: "createdAt");
        
        query3.whereKey("createdAt", greaterThanOrEqualTo: newDate)
        query3.whereKey("createdAt", lessThan: month!)
        
        query3.findObjectsInBackground(block: { (objects, error) in
            if error != nil{
                print(error!)
            }else{
                for object in objects!{
                    
                    self.caloriasMensual=self.caloriasMensual+(object["quantity"] as! Double)
                    
                }
                self.caloriasMonthLabel.text=String(self.caloriasMensual)
                
            }
            
        })
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.tintColor = UIColor.red
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
