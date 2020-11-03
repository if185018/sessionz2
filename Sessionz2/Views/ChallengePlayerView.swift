//
//  ChallengePlayerView.swift
//  Sessionz2
//
//  Created by C4Q on 10/8/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit

protocol MatchSetSelectionDelegate: class {
    func didSelectMatchSet (set:MatchSet)
}

class ChallengePlayerView: UIView {
    
    var user: AppUser? {
        didSet {
            //TODO: Handle setup
        }
    }
    
    public weak var delegate: MatchSetSelectionDelegate?
    
    private lazy var gamerTagLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 18)
           label.textAlignment = .center
           return label
       }()
    
    public var firstToTwoButton: SetButton = {
        let button = SetButton()
        button.tag = 0
        button.matchSet = .firstToTwo
        return button
    }()
     
    public var firstToThreeButton: SetButton = {
        let button = SetButton()
        button.tag = 1
        button.matchSet = .firstToThree
        return button
    }()
    
    public var firstToFiveButton: SetButton = {
        let button = SetButton()
        button.tag = 2
        button.matchSet = .firstToFive
        return button
    }()
    
    public var firstToTenButton: SetButton = {
        let button = SetButton()
        button.tag = 3
        button.matchSet = .firstToTen
        return button
    }()
    
    var buttons = [SetButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondaryBlueTint
        buttons = [firstToTwoButton, firstToThreeButton, firstToFiveButton, firstToTenButton]
        setupButtonsAndLabel()
        activateButtons()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func activateButtons() {
        for button in buttons {
            button.addTarget(self, action: #selector(handleMatchSetButtonSelected(sender:)), for: .touchUpInside)
        }
    }
    
    
    private func setupButtonsAndLabel() {
        addSubview(gamerTagLabel)
        gamerTagLabel.anchor(top:topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 12, paddingRight: 12, height: 24)
        
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.distribution = .fillEqually
        stack.spacing = 6
        stack.axis = .horizontal
        
        addSubview(stack)
        stack.centerX(inView: self)
        stack.anchor(top: gamerTagLabel.bottomAnchor, paddingTop: 9)
        
    }
    
    @objc func handleMatchSetButtonSelected(sender: SetButton) {
        guard let matchSet = sender.matchSet
            else {return}
        buttons.forEach { (button) in
            button.isHighlighted = false
        }
        buttons[sender.tag].isHighlighted = true
        delegate?.didSelectMatchSet(set: matchSet)
    }
    
    
    
    
    
}
