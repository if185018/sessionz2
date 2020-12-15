//
//  ChallengeSortCell.swift
//  Sessionz2
//
//  Created by C4Q on 12/8/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit

class ChallengeSortCell: UITableViewCell {

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
        //Todo: include constraints for cell objects
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
