//
//  ViewController.swift
//  Where Am I
//
//  Created by Rohit Kumar on 2015-06-30.
//  Copyright (c) 2015 RKumar. All rights reserved.
//

import UIKit
//import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    
    @IBOutlet var latitude: UILabel!
    
    @IBOutlet var longitude: UILabel!
    
    @IBOutlet var course: UILabel!
    
    @IBOutlet var altitude: UILabel!
    
    @IBOutlet var speed: UILabel!
    
    @IBOutlet var nearestAddress: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        //println(locations)
        
        //location[0] returns the first loation in the array
        // by default location is an array of AnyObject so we have to cast that as a CLLocation
        var userLocation: CLLocation  = locations[0] as! CLLocation

        latitude.text = "\(userLocation.coordinate.latitude)"
        
        longitude.text = "\(userLocation.coordinate.longitude)"
        
        altitude.text = "\(userLocation.altitude) m"
        
        speed.text = "\(userLocation.speed) m/s"
        
        course.text = "\(userLocation.course)"
        
        
    
        //going from latitude  and longitude to an address
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: {(placemarks, error) -> Void in
            println(userLocation)
            
            if error != nil {
                
                println(error)
                
                /*println("Reverse geocoder failed with error" + error.localizedDescription)
                return*/
            } else {
                
                if let pm = CLPlacemark(placemark: placemarks?[0] as! CLPlacemark){
                    
                    var subThroroughfare:String = ""
                    
                    if (pm.subThoroughfare != nil){
                        
                        subThroroughfare = pm.subThoroughfare
                    }
                
                        println(pm)
                    self.nearestAddress.text = "\(subThroroughfare) \n \(pm.thoroughfare) \n \(pm.subLocality) \n \(pm.subAdministrativeArea) \n \(pm.postalCode) \n \(pm.country)"
                
                }
            }
        })

    }



}

