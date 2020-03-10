//
//  MenuHeader.swift
//  Sessionz2
//
//  Created by C4Q on 3/10/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit

class MenuHeader: UIView {
    
    //MARK: Properties
    private let user: AppUser
    
    
    private lazy var profileImageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        //TODO: Add profile image view here
        return view
    }()
    
    private lazy var gamerTagLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.text = user.gamerTag
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = "test@gmail.com"
        label.text = user.email
        return label
    }()
    
    
    //MARK: Init
    
    init(user: AppUser, frame: CGRect) {
        self.user = user
        super.init(frame: frame)
        
        backgroundColor = .secondaryBlueTint
        
        addSubview(profileImageContainerView)
               profileImageContainerView.anchor(top: topAnchor, left: leftAnchor,
                                       paddingTop: 4, paddingLeft: 12,
                                       width: 64, height: 64)
               profileImageContainerView.layer.cornerRadius = 64 / 2
        
        
        let stack = UIStackView(arrangedSubviews: [gamerTagLabel, emailLabel])
        stack.distribution = .fillEqually
        stack.spacing = 4
        stack.axis = .vertical
        
        addSubview(stack)
        
        stack.centerY(inView: profileImageContainerView,
        leftAnchor: profileImageContainerView.rightAnchor,
        paddingLeft: 12)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    
    //TODO: Work On Pulsing mode switch
}
