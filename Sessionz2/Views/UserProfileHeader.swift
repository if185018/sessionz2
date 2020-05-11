//
//  UserProfileHeader.swift
//  Sessionz2
//
//  Created by C4Q on 5/8/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit

class UserProfileHeader: UITableViewCell {

    //MARK: Properties
    var user: AppUser?
    
    
    
    let profileImageView: UIImageView = {
      let iv = UIImageView()
      iv.contentMode = .scaleAspectFill
      iv.clipsToBounds = true
      iv.backgroundColor = .lightGray
        return iv
    }()
    
    let nameLabel: UILabel = {
           let label = UILabel()
           label.text = "Heath Ledger"
           label.font = UIFont.boldSystemFont(ofSize: 12)
           return label
       }()
    
    

}
