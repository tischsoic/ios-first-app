//
//  ViewController.swift
//  a
//
//  Created by John Smith on 10/16/17.
//  Copyright © 2017 John Smith. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var myLocationManager: CLLocationManager?
    override func viewDidLoad() {
        super.viewDidLoad()
        if (CLLocationManager.locationServicesEnabled())
        {
            myLocationManager = CLLocationManager()
            myLocationManager?.delegate = self
            myLocationManager?.requestWhenInUseAuthorization()
            myLocationManager?.startUpdatingLocation()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(_ manager: CLLocationManager,
                                  didUpdateLocations locations: [CLLocation]){
        print(locations)
        guard let lastLocation = locations.last else {
            return
        }
        print(lastLocation.coordinate)
        print(lastLocation.speed)
        myMapView.setCenter(lastLocation.coordinate, animated: true)
//        let location = locations[0]
//        
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//        
//        self.map.setRegion(region, animated: true)
    }
    
//    func mapViewWillStartLocatingUser(_ mapView: MKMapView) {
//        print("asdf!!!!")
//    }
    
}

