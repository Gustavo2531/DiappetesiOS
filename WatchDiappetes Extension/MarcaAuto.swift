//
//  MarcaAuto.swift
//  Diappetes
//
//  Created by Steven Potts on 3/24/17.
//  Copyright © 2017 Parse. All rights reserved.
//


import WatchKit

class MarcaAuto: NSObject {
    var nombre:String
    var latitude:String
    var longitude:String
    
    init(nome:String,latitud:String,longitud:String)
    {
        nombre=nome
        latitude=latitud
        longitude=longitud
        
        
    }
}
