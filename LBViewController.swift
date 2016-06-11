//
//  LBViewController.swift
//  Ludipics
//
//  Created by Shyamal Anadkat on 2016-03-27.
//  Copyright © 2016 Ludipics. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Foundation
import Parse

class LBViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    
    @IBOutlet var mapView: MKMapView!
    
    var circleOverlay: MKCircle = MKCircle()
    var circleRenderer: MKCircleRenderer = MKCircleRenderer()
    var locationManager: CLLocationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //update location and authorization requests
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        var location = locationManager.location
        
        // Do any additional setup after loading the view.
        locationManagers(locationManager, didUpdateLocations: [location!])
        addRadiusCircle(location!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManagers(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
        
        //extract latitiude and longtigue of the user
        var userLocation: CLLocation = locations[0] as CLLocation
        
        var lat = userLocation.coordinate.latitude
        var lon = userLocation.coordinate.longitude
        
        var latDelta:CLLocationDegrees = 0.05
        var lonDelta:CLLocationDegrees = 0.05
        
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, lon)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        self.mapView.setRegion(region, animated: true)
        //adding pin where user location is
        var pin = MKPointAnnotation()
        pin.coordinate = location
        self.mapView.addAnnotation(pin)
        pin.title = "you're here"
    }
    
    func addRadiusCircle(location: CLLocation){
        self.mapView.delegate = self
        var circle = MKCircle(centerCoordinate: location.coordinate, radius: 8000 as CLLocationDistance)
        self.mapView.addOverlay(circle)
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            var circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = UIColor.redColor()
            circle.fillColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.4)
            circle.lineWidth = 1
            return circle
        } else {
            return MKCircleRenderer()
        }
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
