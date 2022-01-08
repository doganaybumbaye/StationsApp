//
//  ViewController.swift
//  StationsApp
//
//  Created by Doğanay Şahin on 8.01.2022.
//

import UIKit
import MapKit

class ViewController: UIViewController, StationPresenterDelegate, CLLocationManagerDelegate {
    
    lazy var mapView : MKMapView = {
       let map = MKMapView()
        map.overrideUserInterfaceStyle = .light
//        map.showsUserLocation = true
    
        return map
    }()
    

    
    private let presenter = StationPresenter()
    private var stations = [Stations]()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presenter.setViewDelegate(delegate: self)
        presenter.getStations()
        setMapUI()
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()


        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            
        }
        
        mapView.showsUserLocation = true
        mapView.isZoomEnabled = true
        mapView.center = view.center
        mapView.mapType = .standard

        
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = location
//        annotation.title = "your title"
//        mapview.addAnnotation(annotation)
    }
    func presentStations(stations: [Stations]) {
        self.stations = stations
        DispatchQueue.main.async {
//            self.setupMap(name: stations[1].name)
            
        }
        
        
    }
    
    func presentAlert(title: String, message: String) {
        
    }
    
    func setMapUI(){
        view.addSubview(mapView)

        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    func setupMap() {
        
        let latitude: CLLocationDegrees = -12.32456
        let longitude: CLLocationDegrees = 12.21321414
        
        let latDelta: CLLocationDegrees = 0.02
        let lonDelta: CLLocationDegrees = 0.02
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let region = MKCoordinateRegion(center: coordinates, span: span)
        
        let annotation: MKPointAnnotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        
        annotation.title = "name"
        annotation.subtitle = "Your coordinates are \n\(latitude)° N \n\(longitude)° W"
        
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation)
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        
        let coordinates = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        
        let region = MKCoordinateRegion(center: coordinates, span: span)
        mapView.setRegion(region, animated: true)
    }

}
 
