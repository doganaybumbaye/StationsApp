//
//  ListViewController.swift
//  StationsApp
//
//  Created by Doğanay Şahin on 9.01.2022.
//

import Foundation
import UIKit
import MapKit

class ListViewController : UIViewController, UITableViewDelegate, CustomCellDelegate{

    
    func sendBookingRequest() {
        let url = "https://demo.voltlines.com/case-study/6/stations/\(self.selectedStation!)/trips/\(self.clickedID!)"
        guard let postUrl = URL(string: url) else { return }
        var request = URLRequest(url: postUrl)
        request.httpMethod = "POST"
        
        request.httpBody = url.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                
                if httpResponse.statusCode != 200 {
                    self.showCustomPopup()
                }else{
                    print("successssss")
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){
                      
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                }
            }
            
            if let data = data, let dataString = String(data : data, encoding : .utf8){
                print(dataString)
               
            }
            
        }
        task.resume()
        
    }
    

    
    var alltrips : [Trips]!
    var selectedStation : Int!
    var clickedID : Int!
    
    lazy var tripList : UITableView = {
       let list = UITableView()
        
        
        return list
    }()
    
    lazy var titleTrip : UILabel = {
       
        let title = UILabel()
        title.text = "Trips"
        title.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        
        title.textAlignment = .left
        return title
    }()
        
    
    
    override func viewDidLoad() {
        view.backgroundColor = .white
    
       setUpList()
        
        
        
    }
    func setUpList(){
        tripList.delegate = self
        tripList.dataSource = self
        
        tripList.allowsSelection = false
        view.addSubview(tripList)
       
        
        
        
        tripList.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)

        tripList.register(CustomCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(titleTrip)

        titleTrip.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)
    }
}





extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CustomCell
        clickedID = alltrips[indexPath.item].id
        cell.bookButton.tag = clickedID

        
    }
    
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return alltrips.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell

      cell.tripName.text = alltrips[indexPath.row].bus_name
      cell.tripDate.text = alltrips[indexPath.row].time
      clickedID = alltrips[indexPath.row].id
      cell.delegate = self
      
      
    
      return cell
  }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
 
        return titleTrip
    }
}

extension ListViewController {
    
    func showCustomPopup(){
//        I want to animate popup with 1 sec delay in thread
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){
            let alert = Popup()

            self.view.addSubview(alert)
            
        }
        
    }


    
}










