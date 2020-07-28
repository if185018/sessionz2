//
//  NewMessageController.swift
//  Sessionz2
//
//  Created by C4Q on 7/27/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation
import Firebase

private let reuseIdentifier = "NewMessageCell"

class NewMessageController: UITableViewController {

    // MARK: - Properties
    
    
    var users = [AppUser]()
    var messagesController: MessagesController?
    
    
    //MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        
        // register cell
        tableView.register(NewMessageCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        // removes separator views from unused rows
        tableView.tableFooterView = UIView(frame: .zero)
        
        fetchUsers()
        
    }
    
    
    
    
    //MARK: Handlers
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func configureNavigationBar() {
        navigationItem.title = "New Message"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    
    //MARK: API
    
    
    func fetchUsers() {
        REF_USERS.observe(.childAdded) { (snapshot) in
            let uid = snapshot.key
            if uid != Auth.auth().currentUser?.uid {
                FirebaseDatabaseHelper.manager.fetchUserData(uid: uid) { (result) in
                    switch result {
                    case .success(let user):
                        self.users.append(user)
                        self.tableView.reloadData()
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
        
    }
}
