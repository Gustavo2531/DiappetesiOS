//
//  EventVC.swift
//  Diappetes
//
//  Created by Gustavo Méndez on 15/02/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import EventKit

class EventVC: UIViewController {
    
    var startDate = ""
    var endDate = ""
    
    let arrEvent = NSMutableArray()
    
    @IBOutlet weak var tblEvent: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.getAllEvents()
    }
    
    func getAllEvents() {
        
        //
        let eventStore = EKEventStore()
        let calendars = eventStore.calendars(for: .event)
        
        for calendar in calendars {
            print(calendar)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = setDateFormat
            
            let dateStart = dateFormatter.date(from: startDate)!
            let dateEnd = dateFormatter.date(from: endDate)!
            
            let predicate = eventStore.predicateForEvents(withStart: dateStart, end: dateEnd, calendars: [calendar])
            
            let events = eventStore.events(matching: predicate)
            
            for event in events {
                let dict = NSMutableDictionary()
                dict.setValue(event.title, forKey: "title")
                dict.setValue(event.startDate, forKey: "startDate")
                dict.setValue(event.endDate, forKey: "endDate")
                dict.setValue(calendar.title, forKey: "type")
                arrEvent.add(dict)
            }
        }
        tblEvent.reloadData()
        print(arrEvent)
    }
    
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        
    }
    
    
    //MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrEvent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        configureCell(cell, forRowAtIndexPath: indexPath)
        return cell
    }
    
    func configureCell(_ cell: UITableViewCell, forRowAtIndexPath: IndexPath) {
        let dict = arrEvent.object(at: forRowAtIndexPath.row) as! NSDictionary
        
        let lblName = cell.contentView.viewWithTag(1) as! UILabel
        lblName.text = dict.value(forKey: "title") as? String
        
        let lblType = cell.contentView.viewWithTag(2) as! UILabel
        lblType.text = dict.value(forKey: "type") as? String
        
        let lblStartDate = cell.contentView.viewWithTag(3) as! UILabel
        lblStartDate.text = self.convertDateIntoString((dict.value(forKey: "startDate") as? Date)!)
        
        let lblEndDate = cell.contentView.viewWithTag(4) as! UILabel
        lblEndDate.text = self.convertDateIntoString((dict.value(forKey: "endDate") as? Date)!)
    }
    
    func convertDateIntoString(_ dateString : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss +zzz"
        let dateObj = dateFormatter.string(from: dateString)
        return dateObj
    }
    
    
    
    @IBAction func actionBack(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
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
