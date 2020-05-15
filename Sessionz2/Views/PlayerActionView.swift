//
//  PlayerActionView.swift
//  Sessionz2
//
//  Created by Iram Fattah on 3/21/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit

protocol PlayerActionViewDelegate: class {
    //should be handled by Home Controller
    func messageButtonClicked(user: AppUser)
}

class PlayerActionView: UIView {
    //MARK: Properties
    
    
    weak var delegate: PlayerActionViewDelegate?
    
    var user: AppUser? {
        didSet {
            gamerTagLabel.text = user?.gamerTag ?? ""
            consoleLabel.text = user?.consoleType.description ?? ""
        }
    }
    
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
    
    
    
    
    //should go into infoView
    private lazy var consoleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var userConsoleInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondaryBlueTint
        
        view.addSubview(consoleLabel)
        consoleLabel.centerX(inView: view)
        consoleLabel.centerY(inView: view)
        return view
    }()
    
    
    private let messageButton: UIButton = {
        let button = UIButton(type: .system)
               button.backgroundColor = .secondaryBlueTint
               button.setTitle("Message", for: .normal)
               button.setTitleColor(.white, for: .normal)
               button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleMessageClicked), for: .touchUpInside)
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
        
        
        addSubview(userConsoleInfoView)
        userConsoleInfoView.centerX(inView: self)
        userConsoleInfoView.anchor(top: stack.bottomAnchor, paddingTop: 16)
        userConsoleInfoView.setDimensions(height: 80, width: 80)
        userConsoleInfoView.layer.cornerRadius = 80/2
        
        let separatorView = UIView()
        separatorView.backgroundColor = .lightGray
        addSubview(separatorView)
        separatorView.anchor(top: userConsoleInfoView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8, height: 0.75)
        
        addSubview(messageButton)
        messageButton.anchor(left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, paddingLeft: 12, paddingBottom: 12, paddingRight: 12, height: 65)
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func handleMessageClicked() {
        guard let user = user else {return}
        delegate?.messageButtonClicked(user: user)
    }
    
    
    
}
