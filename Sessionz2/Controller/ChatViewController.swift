//
//  ChatViewController.swift
//  Sessionz2
//
//  Created by C4Q on 5/13/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation
import InputBarAccessoryView
import MessageKit

class ChatViewController: MessagesViewController {
    
    //MARK: Properties
    
    private var messages = [Message]()
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}

// MARK: - MessagesDisplayDelegate


extension ChatViewController: MessagesDisplayDelegate {
    
}
// MARK: - MessageInputBarDelegate


extension ChatViewController: InputBarAccessoryViewDelegate {
  
}


// MARK: - UIImagePickerControllerDelegate


extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
}
