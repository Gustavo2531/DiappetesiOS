//
//  DietaViewController.swift
//  Diappetes
//
//  Created by Gustavo Méndez on 10/02/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse
class DietaViewController: UIViewController {
    
    var firstDinner = ""
    var secondDinner = ""
    var thirdDinner = ""
    var firstBreakfast = ""
    var secondBreakFast = ""
    var thirdBreakFast = ""
    var firstMeal = ""
    var secondMeal = ""
    var thirdMeal = ""
    
    @IBOutlet weak var firstBreakfastLabel: UILabel!
    @IBOutlet weak var secondBreakfastLabel: UILabel!
    @IBOutlet weak var thirdBreakfastlabel: UILabel!
    @IBOutlet weak var firstMealLabel: UILabel!
    @IBOutlet weak var secondMealLabel: UILabel!
    @IBOutlet weak var thirdMealLabel: UILabel!
    @IBOutlet weak var firstDinnerLabel: UILabel!
    @IBOutlet weak var secondDinnerLabel: UILabel!
    @IBOutlet weak var thirdDinnerLabel: UILabel!
    
    func obtainDatos(){
        let query = PFQuery(className:"Dieta")
        query.whereKey("userId", equalTo: (PFUser.current()?.objectId)!)
        query.order(byDescending: "createdAt");
        query.getFirstObjectInBackground(block: {(object, error)
            in
            if error != nil{
                self.firstBreakfastLabel.text=self.firstBreakfast
                self.secondBreakfastLabel.text = self.secondBreakFast
                self.thirdBreakfastlabel.text=self.thirdBreakFast
                self.firstMealLabel.text=self.firstMeal
                self.secondMealLabel.text=self.secondMeal
                self.thirdMealLabel.text=self.thirdMeal
                self.thirdDinnerLabel.text=self.thirdDinner
                self.firstDinnerLabel.text=self.firstDinner
                self.secondDinnerLabel.text=self.secondDinner
                print(error!)
            }else{
                
                self.firstDinner=((object?["firstDinner"] as AnyObject).description)
                
                self.secondDinner=((object?["secondDinner"] as AnyObject).description)
                
                self.thirdDinner=((object?["thirdDinner"] as AnyObject).description)
                
                self.firstBreakfast=((object?["firstBreakfast"] as AnyObject).description)
                
                self.secondBreakFast=((object?["secondBreakFast"] as AnyObject).description)
                
                self.thirdBreakFast=((object?["thirdBreakFast"] as AnyObject).description)
                
                self.firstMeal=((object?["firstMeal"] as AnyObject).description)
                
                self.secondMeal=((object?["secondMeal"] as AnyObject).description)
                
                self.thirdMeal=((object?["thirdMeal"] as AnyObject).description)
                
                self.firstBreakfastLabel.text=self.firstBreakfast
                self.secondBreakfastLabel.text = self.secondBreakFast
                self.thirdBreakfastlabel.text=self.thirdBreakFast
                self.firstMealLabel.text=self.firstMeal
                self.secondMealLabel.text=self.secondMeal
                self.thirdMealLabel.text=self.thirdMeal
                self.thirdDinnerLabel.text=self.thirdDinner
                self.firstDinnerLabel.text=self.firstDinner
                self.secondDinnerLabel.text=self.secondDinner
            }
            
        })
    }
    override func viewDidLoad() {
        obtainDatos()

        super.viewDidLoad()
        self.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.red], for:.selected)
        print(self.firstDinner)
       
        // Do any additional setup after loading the view.
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
