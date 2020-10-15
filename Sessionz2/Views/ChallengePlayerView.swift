//
//  ChallengePlayerView.swift
//  Sessionz2
//
//  Created by C4Q on 10/8/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit

class ChallengePlayerView: UIView {
    
    var user: AppUser? {
        didSet {
            //TODO: Handle setup
        }
    }
    
    private lazy var gamerTagLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 18)
           label.textAlignment = .center
           return label
       }()
    
    public var firstToTwoButton: SetButton = {
        let button = SetButton()
        button.matchSet = .firstToTwo
        return button
    }()
     
    public var firstToThreeButton: SetButton = {
        let button = SetButton()
        button.matchSet = .firstToThree
        return button
    }()
    
    public var firstToFiveButton: SetButton = {
        let button = SetButton()
        button.matchSet = .firstToFive
        return button
    }()
    
    public var firstToTenButton: SetButton = {
        let button = SetButton()
        button.matchSet = .firstToTen
        return button
    }()
    
    var buttons = [SetButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buttons = [firstToTwoButton, firstToThreeButton, firstToFiveButton, firstToTenButton]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
