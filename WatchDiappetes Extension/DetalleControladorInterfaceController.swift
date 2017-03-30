//
//  DetalleControladorInterfaceController.swift
//  Diappetes
//
//  Created by Steven Potts on 3/24/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import WatchKit
import Foundation


class DetalleControladorInterfaceController: WKInterfaceController {
 
    @IBOutlet var map: WKInterfaceMap!

    @IBOutlet var nombres: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        let s=context as! MarcaAuto
        let latitud=s.latitude
        let nombre=s.nombre
        let longitud=s.longitude
        nombres.setText(String(nombre))        
        
        let tec=CLLocationCoordinate2D(latitude: (Double(latitud))!, longitude: (Double(longitud))!)
        let region=MKCoordinateRegion(center:tec, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        self.map.setRegion(region)
        self.map.addAnnotation(tec, with: .red)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}
