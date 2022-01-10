//
//  CellPresenter.swift
//  StationsApp
//
//  Created by Doğanay Şahin on 10.01.2022.
//

import UIKit


protocol CustomCellDelegate {
    func sendBookingRequest()
   
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
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        return button
        
        
    }()
    @objc func buttonTap(){
        delegate?.sendBookingRequest()
        
       
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

        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

