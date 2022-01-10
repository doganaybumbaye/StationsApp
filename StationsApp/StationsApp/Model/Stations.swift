//
//  Stations.swift
//  BusStationsApp
//
//  Created by Doğanay Şahin on 8.01.2022.
//

import Foundation

private let urlString = "https://demo.voltlines.com/case-study/6/stations/"

struct Stations : Decodable {
    let center_coordinates : String
    let id : Int
    let name : String
    let trips : [Trips]
    let trips_count : Int
}

struct Trips : Decodable{
    let bus_name : String
    let id : Int
    let time : String
}



//
//func fetchJsonData(completion: @escaping ([Stations], Error?) -> ()) {
//    guard let url = URL(string: urlString) else { return }
//    URLSession.shared.dataTask(with: url) { (data, resp, error) in
//        
//        if error != nil {
//            return
//        }
//        
//        do {
//            let posts = try JSONDecoder().decode([Stations].self, from: data!)
//            completion(posts, nil)
// 
//        } catch {
//
//        }
//        }.resume()
//}







