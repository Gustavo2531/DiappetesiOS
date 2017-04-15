//
//  ChatViewController.swift
//  Diappetes
//
//  Created by Gustavo Méndez on 10/02/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreTelephony

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var names: [String] = []
    var latitude: [String] = []
    var longitude: [String] = []
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 1000.0
        locationManager.requestWhenInUseAuthorization()
        
        
        mapView.mapType=MKMapType.standard
        let cl=CLLocationCoordinate2DMake(19.283996, -99.136006)
        mapView.region=MKCoordinateRegionMakeWithDistance(cl, 5000, 5000)
        /* //esta es otra forma de definir la región de un mapa
         let origen=CLLocationCoordinate2DMake(0.0, 0.0)
         let delta=CLLocationDegrees(0.01)
         let span=MKCoordinateSpanMake(delta, delta)
         let region=MKCoordinateRegionMake(cl, span)
         mapa.setRegion(region, animated: true)
         */

        let url = Bundle.main.path(forResource: "mapas", ofType: "json")
        do {
            
            let allContactsData = try NSData(contentsOfFile: url!, options: NSData.ReadingOptions.mappedIfSafe)
            let allContacts = try JSONSerialization.jsonObject(with: allContactsData as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
            
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
        
        for indice in 0 ..< names.count {
            var punto = CLLocationCoordinate2D()
            punto.latitude = Double(latitude[indice])!
            punto.longitude =  Double(longitude[indice])!
            let pin = MKPointAnnotation()
            pin.coordinate = punto
            pin.title = names[indice]
            mapView.addAnnotation(pin)
            
        }

        
        
        
        
        mapView.showsCompass=true
        mapView.showsScale=true
        mapView.showsTraffic=true
        mapView.isZoomEnabled=true

        
}

        func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
        } else {
            locationManager.stopUpdatingLocation()
            mapView.showsUserLocation = false
        }
    }


    @IBAction func returnMenu(_ sender: Any) {
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
