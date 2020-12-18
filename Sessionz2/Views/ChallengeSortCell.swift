//
//  ChallengeSortCell.swift
//  Sessionz2
//
//  Created by C4Q on 12/8/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit

class ChallengeSortCell: UITableViewCell {

    var challengeSort: ChallengeSort? {
        didSet {
            guard let challengeSort = challengeSort else {return}
            nameLabel.text = challengeSort.type.rawValue
            //TODO: set icon image 
        }
    }
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Test"
        return label
    }()
    
    lazy var icon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv 
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(icon)
        icon.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 3, paddingLeft: 3, paddingBottom: 3, width: 20)
        addSubview(nameLabel)
        nameLabel.anchor(top: topAnchor, left: icon.rightAnchor, bottom: bottomAnchor, paddingTop: 3, paddingLeft: 3, paddingBottom: 3, width: 120)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
