//
//  CountCalorias.swift
//  
//
//  Created by Gustavo Méndez on 21/03/17.
//
//

import Foundation
import RealmSwift

class CountCalorias: Object{
    dynamic var date: Date = Date()
    dynamic var count: Int = Int(0)
    dynamic var dattemp: Int = Int(0)
    func save() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
}
