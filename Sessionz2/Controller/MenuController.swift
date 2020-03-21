//
//  MenuController.swift
//  Sessionz2
//
//  Created by Iram Fattah on 3/10/20.
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
    
    
    private lazy var menuHeader: MenuHeader = {
           let frame = CGRect(x: 0,
                              y: 0,
                              width: self.view.frame.width - 80,
                              height: 140)
           let view = MenuHeader(user: user, frame: frame)
           return view
       }()
    
    init(user: AppUser) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    
    //MARK: Helper Functions 
    func configureTableView() {
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.rowHeight = 60
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableHeaderView = menuHeader
    }
    
    
    
}
