//
//  MessagesController.swift
//  Sessionz2
//
//  Created by C4Q on 7/10/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit
import Firebase


private let reuseIdentifier = "MessagesCell"


class MessagesController: UITableViewController {
    
    //MARK: Properties
    
    var messages = [Message]()
    var messagesDictionary = [String: Message]()
    
    
    
    
    //MARK: Lifeycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        tableView.register(MessageCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView(frame: .zero)
        fetchMessages()
    }
    
    
    
    //MARK: UITableView DataSource/Delegate
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
           return true
       }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 75
       }
       
       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return messages.count
       }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MessageCell
           cell.delegate = self
           cell.message = messages[indexPath.row]
           return cell
       }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let message = messages[indexPath.row]
        let chatPartnerId = message.getChatPartnerId()
        
        USER_MESSAGES_REF.child(uid).child(chatPartnerId).removeValue { (error, ref) in
            self.messages.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = messages[indexPath.row]
        let chatPartnerId = message.getChatPartnerId()
        let cell = tableView.cellForRow(at: indexPath) as! MessageCell
        PlayerService.shared.fetchSingleUser(uid: chatPartnerId) { (user) in
            self.showChatController(for: user)
            cell.messageTextLabel.font = UIFont.systemFont(ofSize: 12)
        }
    }
    
    
    
    //MARK: Setup
    
    func configureNavigationBar() {
        navigationItem.title = "Messages"
        
    }
    
    func showChatController(for user: AppUser) {
        let chatController = ChatController(collectionViewLayout: UICollectionViewFlowLayout())
        chatController.user = user
        let navController = UINavigationController(rootViewController: chatController)
        navController.modalPresentationStyle = .overCurrentContext
               present(navController, animated: true, completion: nil)
    }
    
    
    //MARK: API
    
    func fetchMessage(withMessageId messageId: String) {
        REF_MESSAGES.child(messageId).observeSingleEvent(of:.value) { (snapshot) in
            guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else {return}
            let message = Message(dictionary: dictionary)
            let chatPartnerId = message.getChatPartnerId()
            self.messagesDictionary[chatPartnerId] = message
            self.messages = Array(self.messagesDictionary.values)
            self.messages.sort(by: { (message1, message2) -> Bool in
                return message1.creationDate > message2.creationDate
            })
            
            self.tableView?.reloadData()
        }
    }
    
    func fetchMessages() {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        self.messages.removeAll()
        self.messagesDictionary.removeAll()
        self.tableView.reloadData()
        
        USER_MESSAGES_REF.child(currentUid).observe(.childAdded) { (snapshot) in
            let uid = snapshot.key
            
            USER_MESSAGES_REF.child(currentUid).child(uid).observe(.childAdded) { (snapshot) in
                let messageId = snapshot.key
                self.fetchMessage(withMessageId: messageId)
            }
        }
        
    }
    
    
    
    
}

extension MessagesController: MessageCellDelegate {
    func configureUserData(for cell: MessageCell) {
        guard let chatPartnerId = cell.message?.getChatPartnerId() else {return}
        PlayerService.shared.fetchPlayerData(uid: chatPartnerId) { (user) in
            cell.profileImageView.loadImage(with: user.profileImageURL ?? "")
            cell.usernameLabel.text = user.gamerTag
        }
    }
    
    
}
