//
//  CustomAlert.swift
//  StationsApp
//
//  Created by Doğanay Şahin on 11.01.2022.
//
import UIKit
class Popup : UIView {
    
    lazy var popUpHead : UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        
        label.text = "The trip you selected is full."
        label.numberOfLines = 3
        return label
        
        
    }()
    
    lazy var popUpSub : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = UIFont.systemFont(ofSize: 12, weight: .ultraLight)
        label.text = "Please select another one."
        label.numberOfLines = 3
        label.textAlignment = .left
        return label
        
        
    }()
    
    
    lazy var popUpButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Select a Trip", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 15
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.addTarget(self, action: #selector(animate), for: .touchUpInside)
        return button
        
    }()
    
    lazy var stack : UIStackView = {
       let stacked = UIStackView(arrangedSubviews: [popUpHead,popUpSub,popUpButton])
        stacked.translatesAutoresizingMaskIntoConstraints = false
        stacked.axis = .vertical
        stacked.distribution = .fillEqually
        return stacked
    }()
    
    
    lazy var container : UIView = {
       let view = UIView()
        view.backgroundColor = .white
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc func animate(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
            self.alpha = 0
        } completion: { complete in
            if complete {
                self.removeFromSuperview()
            }
        }

    }
    

    


    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))
        self.frame = UIScreen.main.bounds
        self.addSubview(container)
        
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.20).isActive = true

        container.addSubview(stack)

        stack.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -10).isActive = true
        stack.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 10).isActive = true

      
        stack.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        stack.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.6).isActive = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
