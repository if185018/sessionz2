//
//  PlayerActionView.swift
//  Sessionz2
//
//  Created by Iram Fattah on 3/21/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit


class PlayerActionView: UIView {
    //MARK: Properties
    
    private lazy var gamerTagLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    private let consoleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .white
        label.text = "PS4"
        return label
    }()
    
    
    private let messageButton: UIButton = {
        let button = UIButton(type: .system)
               button.backgroundColor = .black
               button.setTitle("Message", for: .normal)
               button.setTitleColor(.white, for: .normal)
               button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        //TODO: add target for button pressed
               return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        addShadow()
        
        let stack = UIStackView(arrangedSubviews: [gamerTagLabel, fullNameLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fillEqually
        
        //configure stack view with gamer tag and full name labels 
        addSubview(stack)
        stack.centerX(inView: self)
               stack.anchor(top: topAnchor, paddingTop: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
}
