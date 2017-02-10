//
//  TabBarViewController.swift
//  Diappetes
//
//  Created by Gustavo Méndez on 10/02/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
////        if let count = self.tabBar.items?.count {
////            for i in 0...(count-1) {
////                let imageNameForSelectedState   = arrayOfImageNameForSelectedState[i]
////                let imageNameForUnselectedState = arrayOfImageNameForUnselectedState[i]
////                
////                self.tabBar.items?[i].selectedImage = UIImage(named: imageNameForSelectedState)?.withRenderingMode(.alwaysOriginal)
////                self.tabBar.items?[i].image = UIImage(named: imageNameForUnselectedState)?.withRenderingMode(.alwaysOriginal)
////            }
////        }
//        
//        let selectedColor   = UIColor(red: 246.0/255.0, green: 155.0/255.0, blue: 13.0/255.0, alpha: 1.0)
//        let unselectedColor = UIColor(red: 16.0/255.0, green: 224.0/255.0, blue: 223.0/255.0, alpha: 1.0)
//        
//        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: unselectedColor], for: .normal)
//        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: selectedColor], for: .selected)
        // Do any additional setup after loading the view.
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
