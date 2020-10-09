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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .red : .green 
        }
    }
}
