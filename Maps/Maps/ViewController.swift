//
//  ViewController.swift
//  Maps
//
//  Created by Mohammad on 6/4/18.
//  Copyright © 2018 Mohammad Mahjoub. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController, CLLocationManagerDelegate,
MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager : CLLocationManager!
    var placeWestmont = MKPointAnnotation()
    var placeHome = MKPointAnnotation()
    var placeGN = MKPointAnnotation()
    
    
    @IBOutlet weak var locationSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        mapView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
  
    @IBAction func switchButton(_ sender: Any) {
        if locationSwitch.isOn {
            locationManager.requestWhenInUseAuthorization()
            mapView.showsUserLocation = true
            locationManager.startUpdatingHeading()
        } else {
            mapView.showsUserLocation = false
            locationManager.stopUpdatingLocation()
        }
    }
  
    @IBAction func westmontButton(_ sender: Any) {
        placeWestmont.coordinate = CLLocationCoordinate2DMake(34.449998, -119.659539)
        placeWestmont.title = "Westmont College"
        mapView.addAnnotation(placeWestmont)
        mapView.setCenter(placeWestmont.coordinate, animated: true)
    }
    
    @IBAction func homeButton(_ sender: Any) {
        placeHome.coordinate = CLLocationCoordinate2DMake(21.485811, 39.192505)
        placeHome.title = "Home"
        mapView.addAnnotation(placeHome)
    }
    
    @IBAction func gameNewButton(_ sender: Any) {
        placeGN.coordinate = CLLocationCoordinate2DMake(21.574979, 39.145760)
        placeGN.title = "Game Net"
        mapView.addAnnotation(placeGN)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            mapView.setCenter(location.coordinate, animated: true)
        }
    }
}

