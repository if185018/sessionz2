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
    
    
    private let messageButton: UIButton = {
        let button = UIButton(type: .system)
               button.backgroundColor = .black
               button.setTitle("Message", for: .normal)
               button.setTitleColor(.white, for: .normal)
               button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        //TODO: add target for button pressed
               return button
    }()
    
    
    
    
    
    
    
    
}
