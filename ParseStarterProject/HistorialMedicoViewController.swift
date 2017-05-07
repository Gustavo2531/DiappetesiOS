//
//  HistorialMedicoViewController.swift
//  Diappetes
//
//  Created by Gustavo Méndez on 10/02/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse
class HistorialMedicoViewController: UIViewController {

    @IBOutlet weak var glucosaAyun: UILabel!
    @IBOutlet weak var glucosaPost: UILabel!
    @IBOutlet weak var dia: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.red], for:.selected)
        
        let query = PFQuery(className:"Glucose")
        let query2 = PFQuery(className: "GlucosePostrPrandial")
        query2.whereKey("userId", equalTo: (PFUser.current()?.objectId)!)
        query.whereKey("userId", equalTo: (PFUser.current()?.objectId)!)
        query2.order(byDescending: "createdAt");
        query.order(byDescending: "createdAt");
        query.getFirstObjectInBackground(block: {(object, error) in
            if error != nil{
                print(error!)
            }else{
               
                    
                self.glucosaAyun.text = ((object?["quantity"] as AnyObject).description)
               
                
            
                self.dia.text = ((object?["date"] as AnyObject).description)
//
//                print(formatter.string(for: date))
            }
            
        })
        
        query2.getFirstObjectInBackground(block: { (objects, error) in
            if error != nil{
                print(error!)
            }else{
                    self.glucosaPost.text=((objects?["quantity"] as AnyObject).description)
                
                
            }
            
        })
        // Do any additional setup after loading the view.
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
