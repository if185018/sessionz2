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
    
    
}
