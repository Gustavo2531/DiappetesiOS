//
//  MapController.swift
//  Diappetes
//
//  Created by Steven Potts on 3/23/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import WatchKit
import Foundation

class MapController: WKInterfaceController {
    
    
    
    @IBAction func pin() {
    }
    
    @IBOutlet var laTable: WKInterfaceTable!
    var nuevoArray:[Any]?
    
    var names: [String] = []
    var latitude: [String] = []
    var longitude: [String] = []
    
    @IBOutlet var mapa: WKInterfaceMap!
    
    
    @IBAction func hacerZoom(_ value: Float) {
        let grados:CLLocationDegrees=CLLocationDegrees(value)/10
        
        let ventana=MKCoordinateSpanMake(grados, grados)
        let tec=CLLocationCoordinate2D(latitude: 19.283996, longitude: -99.136006)
        let region=MKCoordinateRegionMake(tec, ventana)
        mapa.setRegion(region)
        
        
    }
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Load coordinates
        let tec=CLLocationCoordinate2D(latitude: 19.283996, longitude: -99.136006)
        let region=MKCoordinateRegion(center:tec, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        self.mapa.setRegion(region)
        self.mapa.addAnnotation(tec, with: .purple)
        

        let url=URL(string:"http://199.233.252.86/201711/Diappetes/hospitales2.json")
        do {
            let allContactsData = try Data(contentsOf: url!)
            let allContacts = try JSONSerialization.jsonObject(with: allContactsData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
            if let arrJSON = allContacts["hospitales"] {
                for index in 0...arrJSON.count-1 {
                    
                    let aObject = arrJSON[index] as! [String : AnyObject]

                    names.append(aObject["name"] as! String)
                    latitude.append(aObject["latitude"] as! String)
                    longitude.append(aObject["longitude"] as! String)

                }
            }
        }
        catch {
            
        }
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        
        super.willActivate()
        laTable.setNumberOfRows(names.count, withRowType: "renglones")
        for indice in 0 ..< names.count {
            let elRenglon=laTable.rowController(at: indice) as! controladorRenglon
            let objetoMarca = names[indice]
            elRenglon.name.setTitle(objetoMarca);            

        }
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        let objetoMarca = names[rowIndex]
        let objetoMarca2 = latitude[rowIndex]
        let objetoMarca3 = longitude[rowIndex]

        let d=MarcaAuto(nome: objetoMarca, latitud: objetoMarca2, longitud:objetoMarca3)
        return d
    }
    
}

