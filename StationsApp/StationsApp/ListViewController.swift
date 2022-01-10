//
//  ListViewController.swift
//  StationsApp
//
//  Created by Doğanay Şahin on 9.01.2022.
//

import Foundation
import UIKit

class ListViewController : UIViewController, UITableViewDelegate, CustomCellDelegate{
    func sendBookingRequest(cell: CustomCell) {
        

        print(clickedID!)
        print(selectedStation!)
    }
    

    
    var alltrips : [Trips]!
    var selectedStation : Int!
    var clickedID : Int!
    
    lazy var tripList : UITableView = {
       let list = UITableView()
        return list
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
        
        
        tripList.translatesAutoresizingMaskIntoConstraints = false
        tripList.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tripList.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tripList.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tripList.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tripList.register(CustomCell.self, forCellReuseIdentifier: "cell")
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let indexPath = NSIndexPath(forRow: tag, inSection: 0)
        let cell = tableView.cellForRow(at: indexPath) as! CustomCell
        clickedID = alltrips[indexPath.item].id
        cell.bookButton.tag = clickedID
        //        cell.bookButton.tag =
//        let chosenTitleID = idArray[indexPath.row]
        
    }
    
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return alltrips.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
//      alltrips.forEach {
//          cell.tripName.text = $0.bus_name
//          cell.tripDate.text = $0.time
//
//      }
      cell.tripName.text = alltrips[indexPath.row].bus_name
      cell.tripDate.text = alltrips[indexPath.row].time
      clickedID = alltrips[indexPath.row].id
      cell.delegate = self
      
      
    
      return cell
  }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}





class CustomCell : UITableViewCell {
    var delegate: CustomCellDelegate?
    lazy var tripName : UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Test"
        nameLabel.textColor = .black
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.textAlignment = .left
        return nameLabel
    }()
    
    
    lazy var tripDate : UILabel = {
       let dateLabel = UILabel()
        dateLabel.text = "12:33 AM"
        dateLabel.textColor = .gray
        dateLabel.font = UIFont.boldSystemFont(ofSize: 16)
        dateLabel.textAlignment = .right
        return dateLabel
    }()
    
    lazy var bookButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Book", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
//        button.frame = CGRect(x: 100, y: 100, width: 500, height: 50)
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        return button
        
        
    }()
    @objc func buttonTap(_ sender: AnyObject){
        delegate?.sendBookingRequest(cell: self)

        
    }
    
    
    
    override init(style : UITableViewCell.CellStyle, reuseIdentifier : String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(tripName)
        addSubview(tripDate)
        addSubview(bookButton)
        contentView.isUserInteractionEnabled = true
        let stackView = UIStackView(arrangedSubviews: [tripName,tripDate,bookButton])
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.spacing = 5
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0, enableInsets: false)


        
//        tripName.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 10, paddingRight: 0, width: 90, height: 0, enableInsets: false)
//
//        tripDate.anchor(top: topAnchor, left: tripName.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
//
//        bookButton.anchor(top: topAnchor, left: tripDate.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 5, paddingBottom: 10, paddingRight: 10, width: 0, height: 70, enableInsets: false)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


protocol CustomCellDelegate {
    func sendBookingRequest(cell: CustomCell)
}


