//
//  MenuViewController.swift
//  Diappetes
//
//  Created by Admin on 20/06/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import RealmSwift
class MenuViewController: UIViewController {
    func getVisitorCountsFromDatabase() -> Results<CountCalorias> {
        do {
            let realm = try Realm()
            return realm.objects(CountCalorias.self)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }

    func erase(){
        do{
            let realm = try Realm()
            try! realm.write {
                realm.deleteAll()
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    override func viewDidLoad() {
        
        if getVisitorCountsFromDatabase().count != 0 {
             erase()
        }
       
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "fondo4.png")
        self.view.insertSubview(backgroundImage, at: 0)
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo4.png")!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
