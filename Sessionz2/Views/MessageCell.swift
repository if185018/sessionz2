//
//  MessageCell.swift
//  Sessionz2
//
//  Created by C4Q on 7/13/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit
import Firebase

protocol MessageCellDelegate {
    func configureUserData(for cell: MessageCell)
}

class MessageCell: UITableViewCell {

    //MARK: Properties
    
    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    let timestampLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        label.text = "2h"
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let messageTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    
    

}
