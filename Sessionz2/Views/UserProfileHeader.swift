//
//  UserProfileHeader.swift
//  Sessionz2
//
//  Created by C4Q on 5/8/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit



//may need to change into UITableViewCell


protocol UserProfileHeaderDelegate {
    func setUserStats(for header: UserProfileHeader)
}


class UserProfileHeader: UITableViewHeaderFooterView {

    
    var delegate: UserProfileHeaderDelegate?
    
    //MARK: Properties
    var user: AppUser? {
        didSet {
            setUserStats(for: user)
            guard let profileImageUrl = user?.profileImageURL else { return }
            
            profileImageView.loadImage(with: profileImageUrl)
        }
    }
    
    
    let profileImageView: CustomImageView = {
      let iv = CustomImageView()
      iv.contentMode = .scaleAspectFill
      iv.clipsToBounds = true
      iv.backgroundColor = .lightGray
        return iv
    }()
    
    let gamerTagLabel: UILabel = {
           let label = UILabel()
           label.text = "Jon Moxley"
           label.font = UIFont.boldSystemFont(ofSize: 12)
           return label
       }()
    
    let primaryConsoleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        let attributedText = NSMutableAttributedString(string: "PS4", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "main console", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        label.attributedText = attributedText
        return label
    }()
    
    let matchesWonLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "matches won", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        label.attributedText = attributedText
        return label
    }()
    
    let totalMatchesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "total matches", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        label.attributedText = attributedText
        return label
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        
        profileImageView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
        profileImageView.layer.cornerRadius = 100/2
        
        addSubview(gamerTagLabel)
        gamerTagLabel.anchor(top: profileImageView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 100, height: 0)
        
        configureSepearatorViews()
    }
    
    required init?(coder: NSCoder) {
        //Profile Image Constraints
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    //MARK: Private Methods
    
    func configureUserInfo() {
        let stackView = UIStackView(arrangedSubviews: [primaryConsoleLabel, matchesWonLabel, totalMatchesLabel])
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(top: self.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 50)
    }
    
    func configureSepearatorViews() {
        let topDividerView = UIView()
        topDividerView.backgroundColor = .lightGray
        
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = .lightGray
        
        
        addSubview(topDividerView)
        addSubview(bottomDividerView)
        
        topDividerView.anchor(top: nil, left: leftAnchor, bottom: self.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, width: 0, height: 0.5)
        
         bottomDividerView.anchor(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
    }
    
    
    func setUserStats(for user: AppUser?) {
        delegate?.setUserStats(for: self)
    }
    
}
