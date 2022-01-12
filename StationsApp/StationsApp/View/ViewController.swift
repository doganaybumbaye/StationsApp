//
//  ViewController.swift
//  StationsApp
//
//  Created by Doğanay Şahin on 8.01.2022.
//

import UIKit
import MapKit

class ViewController: UIViewController, StationPresenterDelegate,CLLocationManagerDelegate {

    
    private let presenter = StationPresenter()
    private var stations = [Stations]()
    var selectedAnnotationTrips = [Trips]()
    var selectedStationID : Int!
    let locationManager = CLLocationManager()
    var annotationView : MKAnnotationView!
    var isTapped = false
    
    
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


    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isCompleted()
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

    }
    func presentStations(stations: [Stations]) {
        self.stations = stations
        DispatchQueue.main.async {
            stations.forEach {
                var lat : Double
                var long : Double
                
                let coordinates = $0.center_coordinates.split(separator: ",")
                lat = Double(coordinates[0])!
                long = Double(coordinates[1])!
                self.setupMap(name: $0.name, lat: lat, long: long, tripCount: $0.trips_count)
                
            }

            
        }
        
        
    }
    
    
    func setMapUI(){
        
        view.addSubview(mapView)
        
        mapView.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)

        mapView.addSubview(listButton)
    
        listButton.anchor(top: nil, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 50, paddingRight: 20, width: 0, height: 0, enableInsets: true)
        


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
        annotation.subtitle = "\(tripCount) Trips"
        
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation)
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        
        let coordinates = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        
        let region = MKCoordinateRegion(center: coordinates, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    


    @objc func buttonTap(){
        let vc = ListViewController()
        vc.alltrips = self.selectedAnnotationTrips
        vc.selectedStation = self.selectedStationID
       
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        listButton.isHidden = false
        annotationView.image = UIImage(named: "Selected Point")
        stations.forEach {
            if $0.name == view.annotation?.title {
                selectedAnnotationTrips = $0.trips
                selectedStationID = $0.id
                

            }
            
            
        }
        
    }
    
    
    

   }
 


extension ViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        
//        Checks to users annotation
        if annotation is MKUserLocation {
            return nil
        }

        annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.image = UIImage(named: "Point")
            
            
        } else {
            annotationView?.annotation = annotation
            
        }

        return annotationView
    }
    
    



    
    

    

}

