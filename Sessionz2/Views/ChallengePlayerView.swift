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
    
    func didPressDismissButton()
    
    func didPressConfirmButton()
}

class ChallengePlayerView: UIView {
    
    var user: AppUser? {
        didSet {
            //TODO: Handle setup
            self.gamerTagLabel.text = user?.gamerTag ?? ""
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
    
    private lazy var confirmButton: UIButton = {
         let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 218/255, green: 234/255, blue: 252/255, alpha: 0.7)
               button.setTitleColor(.black, for: .normal)
               button.isEnabled = false
        button.setTitle("Confirm", for: .normal)
               button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleConfirmButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var dismissButton : UIButton = {
        let xButton = UIButton(type: .close)
        xButton.tintColor = .black
        xButton.addTarget(self, action: #selector(handleDismissButtonPressed), for: .touchUpInside)
        return xButton
    }()
    
    
    var buttons = [SetButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2.5
        backgroundColor = .white
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
        stack.spacing = 10
        stack.axis = .horizontal
        
        addSubview(dismissButton)
        dismissButton.anchor(top: self.topAnchor, right: self.rightAnchor, paddingTop: 4, paddingRight: 4, width: 24, height: 24)
        
        addSubview(stack)
        stack.centerX(inView: self)
        stack.anchor(top: gamerTagLabel.bottomAnchor, paddingTop: 9)
        
        addSubview(confirmButton)
        confirmButton.anchor(left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, paddingLeft: 12, paddingBottom: 12, paddingRight: 12, height: 45)
        
    }
    
    public func adjustConfirmButton(shouldEnable: Bool) {
        if shouldEnable {
            confirmButton.backgroundColor = .secondaryBlueTint
            confirmButton.setTitleColor(.white, for: .normal)
            confirmButton.isEnabled = true
        } else {
            confirmButton.backgroundColor = UIColor(red: 218/255, green: 234/255, blue: 252/255, alpha: 0.7)
            confirmButton.setTitleColor(.black, for: .normal)
            confirmButton.isEnabled = false
            
        }
    }
    
    @objc func handleMatchSetButtonSelected(sender: SetButton) {
        guard let matchSet = sender.matchSet
            else {return}
        
        buttons.forEach { (button) in
            button.isSelected = false
        }
        adjustConfirmButton(shouldEnable: true)
        buttons[sender.tag].isSelected = true
        delegate?.didSelectMatchSet(set: matchSet)
    }
    
    
    @objc func handleDismissButtonPressed() {
        adjustConfirmButton(shouldEnable: false)
        delegate?.didPressDismissButton()
    }
    
    
    @objc func handleConfirmButtonPressed() {
        delegate?.didPressConfirmButton()
    }
    
    
}
