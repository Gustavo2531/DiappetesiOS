//
//  RewardsViewController.swift
//  Diappetes
//
//  Created by Gustavo Méndez on 10/02/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit

class RewardsViewController: UIViewController {
    @IBOutlet weak var labelDays: UILabel!

    @IBOutlet weak var labelReward: UILabel!
    @IBAction func compartirAFace(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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
