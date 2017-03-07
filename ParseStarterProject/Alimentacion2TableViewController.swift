//
//  Alimentacion2TableViewController.swift
//  Diappetes
//
//  Created by Gustavo Méndez on 07/03/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse
class Alimentacion2TableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    var names=[String]()
    var apellidos=[String]()
    var calorias=[Double]()
    var searchActive : Bool = false
    var datos=[String]()
    var filtered:[String] = []
    let identificador = "Identificador"
    let direccion="https://intense-river-47104.herokuapp.com/foods/json?query=%22%22"
    
    @IBAction func returnMenu(_ sender: Any) {
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)

    }
    var nuevoArray:[Any]?
    
    func JSONParseArray(string: String) -> [AnyObject]{
        if let data = string.data(using: String.Encoding.utf8){
            
            do{
                
                if let array = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)  as? [AnyObject] {
                    return array
                }
            }catch{
                
                print("error")
                //handle errors here
                
            }
        }
        return [AnyObject]()
    }
    
    func obtainDatos(string:String, carb:Double, pro: Double, gras:Double ){
        self.datos.append(string)
        var car=(carb)*4
        car = car+(pro)*4
        car = car+(gras)*9
        self.calorias.append(car)

    }
    override func viewDidLoad() {
        let url = URL(string: direccion)
        
        let datos2 = try? Data (contentsOf: url!)
        
        nuevoArray = try! JSONSerialization.jsonObject(with: datos2!) as! [Any]

        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        for objects in nuevoArray!{
            let object = objects as! [String:Any]
            obtainDatos(string: object["Nombre"] as! String, carb: object["Carbohidratos"] as! Double, pro:object["Proteina"] as! Double, gras: object["Grasa"] as! Double )
        
        }
         print(self.datos)
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
        return (nuevoArray?.count)!
        //        return datos.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: identificador, for: indexPath)
        if (cell == nil){
            cell = UITableViewCell(style: UITableViewCellStyle.default,reuseIdentifier: identificador)
        }
        if(searchActive){
            cell.textLabel?.text = filtered[indexPath.row]
        } else {

        // Configure the cell...
        
        let objetoMarca = nuevoArray?[indexPath.row] as! [String:Any]
        let s: String = objetoMarca["Nombre"] as! String
        
        
        cell.textLabel?.text=s
        }
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let sigVista=segue.destination as! AlimentosViewController
        let indice = self.tableView.indexPathForSelectedRow?.row
        sigVista.nameFood=datos[indice!]
        sigVista.calorias=calorias[indice!]
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
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
