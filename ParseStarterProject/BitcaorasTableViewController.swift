//
//  BitcaorasTableViewController.swift
//  Diappetes
//
//  Created by Gustavo Méndez on 24/02/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class BitcaorasTableViewController: UITableViewController {
    var diasS = [""]
    var diasE = [""]
    var glucoseAyun = [""]
    var glucosePost = [""]
    let identificador = "Identificador"
    
    func obtainData(){
      
//        var m=diasS
//        var l=diasE
//        if diasS.count>diasE.count{
//            m=diasS
//            l=diasE
//        }else{
//            m=diasS
//            l=diasE
//        }
//        
//        for e in m{
//            if e != ""{
//            var index1 = e.index(e.endIndex, offsetBy: -4)
//                print(e.substring(to: index1))
//            }
////            for s in l{
////                if e.substring(to: 9) == s.substring(to: 9){
////                    
////                
////                }
////            }
//        }
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
    override func viewDidLoad() {
        obtainData()
        super.viewDidLoad()
        let query = PFQuery(className:"Glucose")
        let query2 = PFQuery(className: "GlucosePostrPrandial")
        query2.whereKey("userId", equalTo: (PFUser.current()?.objectId)!)
        query.whereKey("userId", equalTo: (PFUser.current()?.objectId)!)
        query2.order(byDescending: "createdAt");
        query.order(byDescending: "createdAt");
        
        query.findObjectsInBackground(block: { (objects, error) in
            if error != nil{
                print(error!)
            }else{
                for object in objects!{
                    
                    self.glucoseAyun.append((object["quantity"] as AnyObject).description)
                    
                    self.diasS.append((object["date"] as AnyObject).description)
                    self.tableView.reloadData()
                }
            }
            
        })
        
        query2.findObjectsInBackground(block: { (objects, error) in
            if error != nil{
                print(error!)
            }else{
                for object in objects!{
                    self.glucosePost.append((object["quantity"] as AnyObject).description)
                    self.diasE.append((object["date"] as AnyObject).description)
                    self.tableView.reloadData()
                }
            }
            
        })
//        let s: String = self.diasS[0]
//        let ss1: String = (s as NSString).substring(to: 9)
//        print(ss1)
        
//        for object in diasE{
//            for objects in diasS{
//                if object.substring(to: <#T##String.Index#>)
//            }
//        
//        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return diasS.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier:"Cell", for: indexPath)
        configureCell(cell, forRowAtIndexPath: indexPath)
        return cell

    }
    
    func configureCell(_ cell: UITableViewCell, forRowAtIndexPath: IndexPath) {
        var h = forRowAtIndexPath.row + 1
        let lblName = cell.contentView.viewWithTag(1) as! UILabel
        if  h < self.diasS.count{
            lblName.text = self.diasS[h]
        }else {
            lblName.text = " "
        }
        
        
        
        let lblType = cell.contentView.viewWithTag(2) as! UILabel
        
        if h < self.glucoseAyun.count {
             lblType.text = "Glucosa Ayuno :" + self.glucoseAyun[h]
        }else {
             lblType.text = ""
        }
       
        
        let lblStartDate = cell.contentView.viewWithTag(3) as! UILabel
            
        if h < self.diasE.count {
            lblStartDate.text = self.diasE[h]
        }else {
            lblStartDate.text = ""
        }
        
        let lblEndDate = cell.contentView.viewWithTag(4) as! UILabel
        
        if h < self.glucosePost.count {
            lblEndDate.text = "Glucosa Postprandial" + self.glucosePost[h]
        }else {
            lblEndDate.text = ""
        }
        
        
       
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
