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
    
    
    //MARK: UITableView Datasource/Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 75
       }
       
       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return users.count
       }
       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NewMessageCell
           
           cell.user = users[indexPath.row]
           
           return cell
       }
       
       override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
           self.dismiss(animated: true) {
               let user = self.users[indexPath.row]
            self.messagesController?.showChatController(for: user)
           }
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
