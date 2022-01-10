//
//  UserLocationPresenter.swift
//  StationsApp
//
//  Created by Doğanay Şahin on 8.01.2022.
//

import Foundation
import UIKit
import CoreLocation
import MapKit


//protocol userLocationDelegate : class {
//    func showUserLocation()
//}
//
//class UserLocation : CLLocationManager, CLLocationManagerDelegate, userLocationDelegate{
//    func showUserLocation() {
//        func locationManager(<#T##manager: CLLocationManager##CLLocationManager#>, didUpdateLocations: <#T##[CLLocation]#>){
//            
//        }
//    }
//    
//
//    
//    var locationManager:CLLocationManager!
//    var mapView:MKMapView!
//    
//    
//    typealias LocationDelegate = userLocationDelegate?
//
//    
//    
//    public func setDelegateLocation(){
//        locationManager.delegate = self
//        
//    }
//    
//    
//    
//    
//    
//
//}

protocol UserLocationDelegate : AnyObject{
    
}
typealias LocatorDelegate = UserLocationDelegate & CLLocationManagerDelegate


class UserLocation: NSObject, CLLocationManagerDelegate{
    let locationManager = CLLocationManager()
    weak var delegate : LocatorDelegate?
//    weak var locationManager : CLLocationManager!
    
    public func setViewDelegate(delegate : LocatorDelegate){
        self.delegate = delegate
    }
    
    public func enableLocationServices(){
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            print("yes")
            
            
        
            
        }
    }
    

    
    
    

    
    
    
}
//extension UserLocation : CLLocationManagerDelegate{
//    func isEqual(_ object: Any?) -> Bool {
//
//    }
//
//    var hash: Int {
//
//    }
//
//    var superclass: AnyClass? {
//
//    }
//
//    func `self`() -> Self {
//
//    }
//
//    func perform(_ aSelector: Selector!) -> Unmanaged<AnyObject>! {
//
//    }
//
//    func perform(_ aSelector: Selector!, with object: Any!) -> Unmanaged<AnyObject>! {
//
//    }
//
//    func perform(_ aSelector: Selector!, with object1: Any!, with object2: Any!) -> Unmanaged<AnyObject>! {
//
//    }
//
//    func isProxy() -> Bool {
//
//    }
//
//    func isKind(of aClass: AnyClass) -> Bool {
//
//    }
//
//    func isMember(of aClass: AnyClass) -> Bool {
//
//    }
//
//    func conforms(to aProtocol: Protocol) -> Bool {
//
//    }
//
//    func responds(to aSelector: Selector!) -> Bool {
//
//    }
//
//    var description: String {
//
//    }
    
    

