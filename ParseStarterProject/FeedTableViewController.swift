//
//  FeedTableViewController.swift
//  InstagramClone
//
//  Created by Admin on 15/06/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

import Parse

class FeedTableViewController: UITableViewController{

    var imageFiles=[PFFile]()
    var messages=[String]()
    var usernames=[String]()
    var users=[String:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = PFUser.query()
        
        query?.findObjectsInBackground(block: { (objects, error) -> Void in
            
            if let users = objects {
                
                self.messages.removeAll(keepingCapacity: true)
                self.users.removeAll(keepingCapacity: true)
                self.imageFiles.removeAll(keepingCapacity: true)
                self.usernames.removeAll(keepingCapacity: true)
                
                for object in users {
                    
                    if let user = object as? PFUser {
                        
                        self.users[user.objectId!] = user.username!
                        
                    }
                }
            }
            
            
            let getFollowedUsersQuery = PFQuery(className: "followers")
            
            getFollowedUsersQuery.whereKey("follower", equalTo: PFUser.current()!.objectId!)
            
            getFollowedUsersQuery.findObjectsInBackground { (objects, error) -> Void in
                print("Si entro")
                if let objects = objects {
                    
                    for object in objects {
                        
                        let followedUser = object["following"] as! String
                        
                        let query = PFQuery(className: "Post")
                        
                        query.whereKey("usedId", equalTo: followedUser)
                        
                        query.findObjectsInBackground(block: { (objects, error) -> Void in
                            
                            if let objects = objects {
                                
                                for object in objects {
                                    
                                    self.messages.append(object["message"] as! String)
                                    
                                    self.imageFiles.append(object["imageFile"] as! PFFile)
                                    
                                    self.usernames.append(self.users[object["usedId"] as! String]!)
                                    
                                    self.tableView.reloadData()
                                    
                                }
                                
                            }
                            
                            
                        })
                    }
                    
                }
                
            }
            
        })
        
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
        return usernames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! cell
        
        imageFiles[indexPath.row].getDataInBackground { (data, error) in
            if let downloadedImage = UIImage(data: data!){
                myCell.postedImage.image = downloadedImage
                

            }
        }
        
        myCell.username.text = usernames[indexPath.row]
        
        myCell.message.text = messages[indexPath.row]
        

        // Configure the cell...

        return myCell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
