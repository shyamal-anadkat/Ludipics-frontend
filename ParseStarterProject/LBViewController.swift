//
//  LBViewController.swift
//  Ludipics
//
//  Created by Shyamal Anadkat on 2016-03-27.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LBViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var map: MKMapView!
    
    var locationManager = CLLocationManager()
    //testcommit
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //update location and authorization requests
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [CLLocation]!) {
        
        print(locations)
        
        //extract latitiude and longtigue of the user
        var userLocation: CLLocation = locations[0] as! CLLocation
        
        var lat = userLocation.coordinate.latitude
        var lon = userLocation.coordinate.longitude
        
        var latDelta:CLLocationDegrees = 0.05
        var lonDelta:CLLocationDegrees = 0.05
        
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, lon)
        
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        self.map.setRegion(region, animated: false)
        
        
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
