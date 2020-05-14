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

extension ChatViewController: MessagesLayoutDelegate {
    
    func avatarSize(for message: MessageType, at indexPath: IndexPath,
      in messagesCollectionView: MessagesCollectionView) -> CGSize {

      return .zero
    }
    
    func footerViewSize(for message: MessageType, at indexPath: IndexPath,
      in messagesCollectionView: MessagesCollectionView) -> CGSize {

   
      return CGSize(width: 0, height: 8)
    }
    
    
    func heightForLocation(message: MessageType, at indexPath: IndexPath,
      with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat {

    
      return 0
    }
    
}
