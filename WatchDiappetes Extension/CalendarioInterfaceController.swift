//
//  CalendarioInterfaceController.swift
//  Diappetes
//
//  Created by Héctor Carlos Flores Reynoso on 3/23/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import WatchKit
import Foundation
import EventKit

class CalendarioInterfaceController: WKInterfaceController {
    
    var rows: [String] = []

    @IBOutlet var table: WKInterfaceTable!
 
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let eventStore = EKEventStore()
        
        eventStore.requestAccess(to: EKEntityType.event, completion:
            {(granted, error) in
                if !granted {
                    print("Access to store not granted")
                }
        })
        
        let calendars = eventStore.calendars(for: EKEntityType.event)
        
        for calendar in calendars as [EKCalendar] {
            
               
                let dateFormatter = DateFormatter()
                
                var date=Date()
                
                let format=DateFormatter()
                format.dateFormat = "dd-MM-yyyy HH:mm"
                
                dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
                let oldDate = dateFormatter.date(from: format.string(from: date))
                
                
                date.addTimeInterval(5*60*60*24)

                dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
                let newDate = dateFormatter.date(from: format.string(from: date))
                
                let predicates = eventStore.predicateForEvents(withStart: oldDate!, end: newDate!, calendars: [calendar])
                let eventos=eventStore.events(matching: predicates)
                
                
                for (_, item) in eventos.enumerated() {
                    puts("\(item.title)")
                    rows.append("\(item.title)")
                }
                
            
        }
        
        let font = UIFont(name: "Times New Roman", size: 12)!
        let fontAttrs = [NSFontAttributeName : font]
        
        table.setNumberOfRows(rows.count, withRowType: "MainRowType")
        for (i,_) in rows.enumerated(){
            let row=table.rowController(at: i) as! MyRowController
            let attrsString = NSAttributedString(string: rows[i], attributes: fontAttrs)
            row.itemLabel.setAttributedText(attrsString)
        }
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
