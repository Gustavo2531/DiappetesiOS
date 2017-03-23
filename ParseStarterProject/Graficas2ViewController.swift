//
//  Graficas2ViewController.swift
//  Diappetes
//
//  Created by Gustavo Méndez on 21/03/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Charts
import Parse
import RealmSwift
class Graficas2ViewController: UIViewController {
    weak var axisFormatDelegate: IAxisValueFormatter?

    @IBOutlet weak var barView: BarChartView!
    var val1=0.0
    var val2=0.0
    var val3=0.0
    var val4=0.0
    var val5=0.0
    var val6=0.0
    var val7=0.0
    
    func obtainDatos(){
       
        var calendar = NSCalendar.autoupdatingCurrent
        calendar.timeZone = NSTimeZone(forSecondsFromGMT: 0) as TimeZone
        
        let today = Date()
        let cal = Calendar(identifier: .gregorian)
        let newDate = cal.startOfDay(for: today)
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: newDate)
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: newDate)
        let yesterday2 = Calendar.current.date(byAdding: .day, value: -2, to: newDate)
        let yesterday3 = Calendar.current.date(byAdding: .day, value: -3, to: newDate)
        let yesterday4 = Calendar.current.date(byAdding: .day, value: -4, to: newDate)
        let yesterday5 = Calendar.current.date(byAdding: .day, value: -5, to: newDate)
         let yesterday6 = Calendar.current.date(byAdding: .day, value: -6, to: newDate)
        
        let query2 = PFQuery(className:"Food")
        query2.whereKey("userId", equalTo: (PFUser.current()?.objectId)!)
        query2.order(byDescending: "createdAt");
        
        query2.whereKey("createdAt", greaterThanOrEqualTo: newDate)
        query2.whereKey("createdAt", lessThan: tomorrow!)
        
        query2.findObjectsInBackground(block: { (objects, error) in
            if error != nil{
                print(error!)
            }else{
                for object in objects!{
                    
                    self.val1=self.val1+(object["quantity"] as! Double)
                    
                    
                }
                let formatter = DateFormatter()
                formatter.dateFormat = "dd"
                let stringFromDate: String = formatter.string(from: newDate)
                let integerDate: Int = Int(stringFromDate)!
                
                let visitorCount = CountCalorias()
                visitorCount.count=Int(self.val1)
                 visitorCount.dattemp=integerDate
                print(visitorCount.count)
                visitorCount.save()
                self.updateChartWithData()

            }
           
            
        })
        
        let query1 = PFQuery(className:"Food")
        query1.whereKey("userId", equalTo: (PFUser.current()?.objectId)!)
        query1.order(byDescending: "createdAt");
        
        query1.whereKey("createdAt", greaterThanOrEqualTo: yesterday!)
        query1.whereKey("createdAt", lessThan: newDate)
        
        query1.findObjectsInBackground(block: { (objects, error) in
            if error != nil{
                print(error!)
            }else{
                for object in objects!{
                    
                    self.val2=self.val2+(object["quantity"] as! Double)
                    
                    
                }
                let formatter = DateFormatter()
                formatter.dateFormat = "dd"
                let stringFromDate: String = formatter.string(from: yesterday!)
                let integerDate: Int = Int(stringFromDate)!
               
                let visitorCount = CountCalorias()
                visitorCount.count=Int(self.val2)
                 visitorCount.dattemp=integerDate
                print(visitorCount.count)
                visitorCount.save()
                self.updateChartWithData()

            }
           
            
        })
        
        
        let query3 = PFQuery(className:"Food")
        query3.whereKey("userId", equalTo: (PFUser.current()?.objectId)!)
        query3.order(byDescending: "createdAt");
        
        query3.whereKey("createdAt", greaterThanOrEqualTo: yesterday2!)
        query3.whereKey("createdAt", lessThan: yesterday!)
        
        query3.findObjectsInBackground(block: { (objects, error) in
            if error != nil{
                print(error!)
            }else{
                for object in objects!{
                    
                    self.val3=self.val3+(object["quantity"] as! Double)
                    
                    
                }
                let formatter = DateFormatter()
                formatter.dateFormat = "dd"
                let stringFromDate: String = formatter.string(from: yesterday2!)
                let integerDate: Int = Int(stringFromDate)!
                
                let visitorCount = CountCalorias()
                visitorCount.count=Int(self.val3)
                 visitorCount.dattemp=integerDate
                print(visitorCount.count)
                visitorCount.save()
                self.updateChartWithData()

            }
            
        })
        
        let query4 = PFQuery(className:"Food")
        query4.whereKey("userId", equalTo: (PFUser.current()?.objectId)!)
        query4.order(byDescending: "createdAt");
        
        query4.whereKey("createdAt", greaterThanOrEqualTo: yesterday3!)
        query4.whereKey("createdAt", lessThan: yesterday2!)
        
        query4.findObjectsInBackground(block: { (objects, error) in
            if error != nil{
                print(error!)
            }else{
                for object in objects!{
                    
                    self.val4=self.val4+(object["quantity"] as! Double)
                    
                    
                }
                let formatter = DateFormatter()
                formatter.dateFormat = "dd"
                let stringFromDate: String = formatter.string(from: yesterday3!)
                let integerDate: Int = Int(stringFromDate)!
                
                let visitorCount = CountCalorias()
                visitorCount.count=Int(self.val4)
                 visitorCount.dattemp=integerDate
                print(visitorCount.count)
                visitorCount.save()
                self.updateChartWithData()

            }
            
            
        })
        
        
        let query5 = PFQuery(className:"Food")
        query5.whereKey("userId", equalTo: (PFUser.current()?.objectId)!)
        query5.order(byDescending: "createdAt");
        
        query5.whereKey("createdAt", greaterThanOrEqualTo: yesterday4!)
        query5.whereKey("createdAt", lessThan: yesterday3!)
        
        query5.findObjectsInBackground(block: { (objects, error) in
            if error != nil{
                print(error!)
            }else{
                for object in objects!{
                    
                    self.val5=self.val5+(object["quantity"] as! Double)
                    
                    
                }
                
                let formatter = DateFormatter()
                formatter.dateFormat = "dd"
                let stringFromDate: String = formatter.string(from: yesterday4!)
                let integerDate: Int = Int(stringFromDate)!
                let visitorCount = CountCalorias()
                visitorCount.count=Int(self.val5)
                visitorCount.dattemp=integerDate
                print(visitorCount.count)
                visitorCount.save()
                self.updateChartWithData()

            }
           
            
        })
        
        
        let query6 = PFQuery(className:"Food")
        query6.whereKey("userId", equalTo: (PFUser.current()?.objectId)!)
        query6.order(byDescending: "createdAt");
        
        query6.whereKey("createdAt", greaterThanOrEqualTo: yesterday5!)
        query6.whereKey("createdAt", lessThan: yesterday4!)
        
        query6.findObjectsInBackground(block: { (objects, error) in
            if error != nil{
                print(error!)
            }else{
                for object in objects!{
                    
                    self.val6=self.val6+(object["quantity"] as! Double)
                    
                    
                }
                let formatter = DateFormatter()
                formatter.dateFormat = "dd"
                let stringFromDate: String = formatter.string(from: yesterday5!)
                let integerDate: Int = Int(stringFromDate)!
                
                 let visitorCount = CountCalorias()
                visitorCount.count=Int(self.val6)
                visitorCount.dattemp=integerDate
                print(visitorCount.count)
                visitorCount.save()
                self.updateChartWithData()

            }
           
            
        })
        
        
        
        let query7 = PFQuery(className:"Food")
        query7.whereKey("userId", equalTo: (PFUser.current()?.objectId)!)
        query7.order(byDescending: "createdAt");
        
        query7.whereKey("createdAt", greaterThanOrEqualTo: yesterday6!)
        query7.whereKey("createdAt", lessThan: yesterday5!)
        
        query7.findObjectsInBackground(block: { (objects, error) in
            if error != nil{
                print(error!)
            }else{
                for object in objects!{
                    
                    self.val7=self.val7+(object["quantity"] as! Double)
                    
                    
                }
                let formatter = DateFormatter()
                formatter.dateFormat = "dd"
                let stringFromDate: String = formatter.string(from: yesterday6!)
                let integerDate: Int = Int(stringFromDate)!
               
                let visitorCount = CountCalorias()
                visitorCount.count=Int(self.val7)
                print(visitorCount.count)
                visitorCount.dattemp=integerDate
                visitorCount.save()
                self.updateChartWithData()
                
                
            }
            
        })
        
        
    }
    func getVisitorCountsFromDatabase() -> Results<CountCalorias> {
        do {
            let realm = try Realm()
            return realm.objects(CountCalorias.self)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func updateChartWithData() {
        var dataEntries: [BarChartDataEntry] = []
        let visitorCounts = getVisitorCountsFromDatabase()
        print("Hay estos datos \(visitorCounts.count)")
        for i in 0..<visitorCounts.count {
//            let timeIntervalForDate: TimeInterval = visitorCounts[i].date.timeIntervalSince1970
            let dataEntry = BarChartDataEntry(x: Double(visitorCounts[i].dattemp), y: Double(visitorCounts[i].count))
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Visitor count")
        let chartData = BarChartData(dataSet: chartDataSet)
        barView.data = chartData
//        let xaxis = barView.xAxis
//        xaxis.valueFormatter = axisFormatDelegate
    }
    
    func erase(){
        do{
            let realm = try Realm()
            try! realm.write {
                realm.deleteAll()
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    @IBAction func returnMenu(_ sender: Any) {
        erase()
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        obtainDatos()
        
//        axisFormatDelegate = self
        
        
        
       
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: axisFormatDelegate
//extension Graficas2ViewController: IAxisValueFormatter {
//    
//    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd"
//        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
//    }
//    
//}

