//
//  MenuController.swift
//  Sessionz2
//
//  Created by C4Q on 3/10/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit

fileprivate let reuseIdentifier = "menuCell"

 enum MenuOptions: Int, CaseIterable, CustomStringConvertible {
    case history
    case settings
    case logout
    
    var description: String {
        switch self {
        case .history : return "History"
        case .settings: return "Settings"
        case .logout: return "Log Out"
        }
    }
}

protocol MenuControllerDelegate: class {
    func didSelect(option: MenuOptions)
}

class MenuController: UITableViewController {
    
    //MARK: Properties
    
    private let user: AppUser
    weak var delegate: MenuControllerDelegate?
    
    init(user: AppUser) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
}
