//
//  MedicosTableViewController.swift
//  Diappetes
//
//  Created by Gustavo Méndez on 01/03/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse
class MedicosTableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    var names=[String]()
    var apellidos=[String]()
    var usernames=[String]()
    var direccion=[String]()
    var searchActive : Bool = false
    var datos=[String]()
      var filtered:[String] = []
    let identificador = "Identificador"
    @IBAction func returnMenu(_ sender: Any) {
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)

    }
    
   
    
    private func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = true
        
        // Remove focus from the search bar.
        searchBar.endEditing(true)
        
        // Perform any necessary work.  E.g., repopulating a table view
        // if the search bar performs filtering.
    }
    
    func obtatinData(){
    
        let query = PFUser.query()
        query?.whereKey("isDoctor", equalTo: true)
        
        query?.findObjectsInBackground(block: { (objects, error) in
            if error != nil{
                print(error!)
            }else{
                for object in objects!{
                    self.names.append((object["name"] as AnyObject).description)
                    self.usernames.append((object["username"] as AnyObject).description)
                    self.direccion.append((object["direccion"] as AnyObject).description)
                    self.apellidos.append((object["apellido"] as AnyObject).description)
                        let h=(object["name"] as AnyObject).description+" "+(object["apellido"] as AnyObject).description
                    print(h)
                        self.datos.append((h))
                    self.tableView.reloadData()
                }
            }
            
        })
        
    }
    override func viewDidLoad() {
        obtatinData()
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self

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
        if(searchActive) {
            return filtered.count
        }
        return usernames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: identificador, for: indexPath)
        if (cell == nil){
            cell = UITableViewCell(style: UITableViewCellStyle.default,reuseIdentifier: identificador)
        }
        if(searchActive){
            if(filtered.count>0){
            cell.textLabel?.text = "Dr.(a) "+filtered[indexPath.row]
            }
        } else {
        // Configure the cell...
        
        let objetoMarca = "Dr.(a) "+names[indexPath.row]+" "+apellidos[indexPath.row]
            cell.textLabel?.text=objetoMarca
        }
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sigVista=segue.destination as! DetailMedicoViewController
        let indice = self.tableView.indexPathForSelectedRow?.row
        if(searchActive){
            sigVista.nombre=filtered[indice!]
            var i=0
            while(filtered[indice!] != datos[i]){
                i += 1
            }
            if (i >= apellidos.count){
                i=i-1
            }
            sigVista.apellido=apellidos[i]
            sigVista.direccion=direccion[i]
            sigVista.userName=usernames[i]
        
        } else {
            sigVista.nombre=names[indice!]+" "+apellidos[indice!]
            sigVista.apellido=apellidos[indice!]
            sigVista.direccion=direccion[indice!]
            sigVista.userName=usernames[indice!]
        }
       
        
        
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
        self.searchBar.endEditing(true)
        self.searchBar.resignFirstResponder()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        self.searchBar.endEditing(true)
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        self.searchBar.endEditing(true)
        self.searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = datos.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
           let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
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
