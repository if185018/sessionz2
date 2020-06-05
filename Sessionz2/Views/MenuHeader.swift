//
//  MenuHeader.swift
//  Sessionz2
//
//  Created by Iram Fattah on 3/10/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit


protocol MenuHeaderDelegate: class {
    func didSelectHeader(user: AppUser)
}

class MenuHeader: UIView {
    
    //MARK: Properties
    private let user: AppUser
    
    public weak var delegate: MenuHeaderDelegate?
    
    private var tapGesture: UITapGestureRecognizer!
    
    private lazy var profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.loadImage(with: self.user.profileImageURL ?? "")
        return iv
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
        label.text = user.email
        return label
    }()
    
    
    //MARK: Init
    
    init(user: AppUser, frame: CGRect) {
        self.user = user
        super.init(frame: frame)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerTapped))
        self.addGestureRecognizer(tapGesture)
        
        backgroundColor = .secondaryBlueTint
        
        addSubview(profileImageView)
               profileImageView.anchor(top: topAnchor, left: leftAnchor,
                                       paddingTop: 4, paddingLeft: 12,
                                       width: 64, height: 64)
               profileImageView.layer.cornerRadius = 64 / 2
        profileImageView.layer.borderWidth = 1.2
        profileImageView.layer.masksToBounds = false
        profileImageView.clipsToBounds = true 
        profileImageView.layer.borderColor = UIColor.black.cgColor
        

        let stack = UIStackView(arrangedSubviews: [gamerTagLabel, emailLabel])
        stack.distribution = .fillEqually
        stack.spacing = 4
        stack.axis = .vertical
        
        addSubview(stack)
        
        stack.centerY(inView: profileImageView,
        leftAnchor: profileImageView.rightAnchor,
        paddingLeft: 12)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    //MARK: OBJC FUNCS
    
    @objc func headerTapped() {
        print("Header Tapped")
        delegate?.didSelectHeader(user: self.user)
    }
    
    
    //TODO: Work On Pulsing mode switch
}
