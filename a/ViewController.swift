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
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBAction func startBtnClicked(_ sender: Any) {
        trackUserLocation = true
        
        stopBtn.isEnabled = true
        startBtn.isEnabled = false
        
        stopBtn.alpha = 1
        startBtn.alpha = 0.5
    }
    @IBAction func stopBtnClicked(_ sender: Any) {
        trackUserLocation = false
        
        stopBtn.isEnabled = false
        startBtn.isEnabled = true
        
        stopBtn.alpha = 0.5
        startBtn.alpha = 1
    }
    @IBAction func clearBtnClicked(_ sender: Any) {
        map.removeAnnotations(map.annotations)
    }
    
    var trackUserLocation: Bool = false
    
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
    
    func setAddressLabel(address: String) {
        addressLabel.text = address
    }

    func locationManager(_ manager: CLLocationManager,
                                  didUpdateLocations locations: [CLLocation]){
        if !trackUserLocation {
            return
        }
        
        print(locations)
        guard let lastLocation = locations.last else {
            return
        }
        print(lastLocation.coordinate)
        print(lastLocation.speed)
        
        map.setCenter(lastLocation.coordinate, animated: true)
        
        let latLonDelta = lastLocation.speed != -1.0 ? lastLocation.speed / 2000 : 0.05
        let span = MKCoordinateSpanMake(latLonDelta, latLonDelta)
        let region = MKCoordinateRegionMake(lastLocation.coordinate, span)
        map.setRegion(region, animated: true)
        
        let marker = MKPointAnnotation()
        marker.coordinate = lastLocation.coordinate
        map.addAnnotation(marker)
        
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude)
        
        geocoder.reverseGeocodeLocation(location, completionHandler:
            {(placemarks, error) in
                if (error != nil) {
                    return
                }
            
                if let pms = placemarks {
                    if pms.count > 0 {
                        let placemark = pms[0]
                        var fullAddress = ""
                        
                        if let subLocality: String = placemark.subLocality {
                            fullAddress = fullAddress + " " + subLocality
                        }
                        if let thoroughfare: String = placemark.thoroughfare {
                            fullAddress = fullAddress + " " + thoroughfare
                        }
                        if let locality: String = placemark.locality {
                            fullAddress = fullAddress + " " + locality
                        }
                        if let country: String = placemark.country {
                            fullAddress = fullAddress + " " + country
                        }
                        if let postalCode: String = placemark.postalCode {
                            fullAddress = fullAddress + " " + postalCode
                        }
                        
                        self.setAddressLabel(address: fullAddress)
                    }
                }
            
        })
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

