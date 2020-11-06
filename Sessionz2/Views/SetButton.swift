//
//  SetButton.swift
//  Sessionz2
//
//  Created by C4Q on 10/9/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit



class SetButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray 
        setTitleColor(.black, for: .normal)
        heightAnchor.constraint(equalToConstant: 45).isActive = true
        widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        self.layer.cornerRadius = 45/2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .red : .lightGray
        }
    }

    
    
    var matchSet: MatchSet! {
        didSet {
            switch matchSet {
            case .firstToTwo :
                self.setTitle("2/3", for: .normal)
            case .firstToThree :
                self.setTitle("3/5", for: .normal)
            case .firstToFive :
                self.setTitle("5/9", for: .normal)
            case .firstToTen:
                self.setTitle("10/19", for: .normal)
            case .none:
                return
            }
        }
    }
        
    
}
