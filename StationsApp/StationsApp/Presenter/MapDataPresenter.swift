//
//  MapDataPresenter.swift
//  StationsApp
//
//  Created by Doğanay Şahin on 8.01.2022.
//

import Foundation
import UIKit
import CoreLocation
protocol StationPresenterDelegate : AnyObject{
    func presentStations(stations : [Stations])
    func presentAlert(title : String , message : String)
    
}

typealias PresenterDelegate = StationPresenterDelegate & UIViewController 

class StationPresenter {
    weak var delegate : PresenterDelegate?
    
    public func getStations(){
        guard let url = URL(string: "https://demo.voltlines.com/case-study/6/stations/") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let stations = try JSONDecoder().decode([Stations].self, from: data)
                
                self?.delegate?.presentStations(stations: stations)
                
            }catch{
                print(error.localizedDescription)
            }
        }
            task.resume()
        
        
        
        
    }
    
    
    

    
    
    
    
    public func setViewDelegate(delegate : PresenterDelegate ){
        self.delegate = delegate
    }
    
    
}


