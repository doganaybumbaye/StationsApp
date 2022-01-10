//
//  ViewController.swift
//  StationsApp
//
//  Created by Doğanay Şahin on 8.01.2022.
//

import UIKit
import MapKit

class ViewController: UIViewController, StationPresenterDelegate,UserLocationDelegate,CLLocationManagerDelegate {
    lazy var listButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("List Trips", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.isHidden = true
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        
        return button
    }()
    
    
    lazy var mapView : MKMapView = {
       let map = MKMapView()
        map.overrideUserInterfaceStyle = .light
        map.showsUserLocation = true
        map.isZoomEnabled = true
        map.center = view.center
        map.mapType = .standard
        map.isScrollEnabled = true
        return map
    }()
    


    
    private let presenter = StationPresenter()
    private let userPresenter = UserLocation()
    private var stations = [Stations]()
    var selectedAnnotationTrips = [Trips]()
    var selectedStationID : Int!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presenter.setViewDelegate(delegate: self)
        presenter.getStations()
        setMapUI()

        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self

        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()

        }
        
        


        
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = location
//        annotation.title = "your title"
//        mapview.addAnnotation(annotation)
    }
    func presentStations(stations: [Stations]) {
        self.stations = stations
        DispatchQueue.main.async {
            
//            self.setupMap(name: stations[0].name,tripCount: stations[0].trips_count)
            print(type(of: stations))
            print(stations[0].trips[0])
            stations.forEach {
                var lat : Double
                var long : Double
                
//                print($0.name)
                
                let coordinates = $0.center_coordinates.split(separator: ",")
                lat = Double(coordinates[0])!
                long = Double(coordinates[1])!
                self.setupMap(name: $0.name, lat: lat, long: long, tripCount: $0.trips_count)
                
            }
//            print(stations.id)
            
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
        
        
        listButton.translatesAutoresizingMaskIntoConstraints = false
        mapView.addSubview(listButton)
        listButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
        listButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        listButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true

    }
    
    func setupMap(name: String, lat : CLLocationDegrees, long : CLLocationDegrees, tripCount : Int) {
        
        let latitude: CLLocationDegrees = lat
        let longitude: CLLocationDegrees = long
        let latDelta: CLLocationDegrees = 0.02
        let lonDelta: CLLocationDegrees = 0.02
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let region = MKCoordinateRegion(center: coordinates, span: span)
        
        let annotation: MKPointAnnotation = MKPointAnnotation()
        
        
        annotation.coordinate = coordinates
        
        annotation.title = name
        annotation.subtitle = "\(tripCount)Trips"
        
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
    
    


    @objc func buttonTap(){
        print("listed")
        let vc = ListViewController()
        vc.alltrips = self.selectedAnnotationTrips
        vc.selectedStation = self.selectedStationID
        
        
        
//        performSegue(withIdentifier: "ListView", sender: self)
        self.present(vc, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        listButton.isHidden = false
        stations.forEach {
            if $0.name == view.annotation?.title {
                selectedAnnotationTrips = $0.trips
                selectedStationID = $0.id
                print(selectedAnnotationTrips)
//                self.selectedAnnotationIndex = $0.trips
            }
            
            
        }
        
    }
    
    
    

   }
 


extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"

        if annotation is MKUserLocation {
            return nil
        }

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.image = UIImage(named: "Point")

            // if you want a disclosure button, you'd might do something like:
            //
            // let detailButton = UIButton(type: .detailDisclosure)
            // annotationView?.rightCalloutAccessoryView = detailButton
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }
    
    func changeImage(){
        
    }
}
