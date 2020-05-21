//
//  Message.swift
//  Sessionz2
//
//  Created by C4Q on 5/13/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation
import MessageKit


//MARK: CONSTANTS

fileprivate let sentDateKey = "sentDate"
fileprivate let senderIDKey = "senderID"
fileprivate let senderNameKey = "senderName"
fileprivate let contentKey = "content"
fileprivate let urlKey = "url"


struct Message: MessageType {
  
    
    var id: String?
    //user is the SENDER 
    var user: AppUser
    
    var sender: SenderType {
        return user
    }
    
    var messageId: String {
        return id ?? UUID().uuidString
    }
    
    var sentDate: Date
    
    var kind: MessageKind
    
    var image: UIImage? = nil
    var downloadURL: URL? = nil
    
    
    //USED IF ONLY TEXT IS SENT
    init(user: AppUser, content: String) {
        self.user = user
        self.kind = .text(content)
        self.sentDate = Date()
        self.id = nil
    }
    //USED IF ONLY IMAGE IS SENT
    init(user: AppUser, photo: MessagePhoto) {
        self.user = user
        self.image = photo.image
        self.kind = .photo(photo)
        self.sentDate = Date()
        self.id = nil
        
    }
    
    
    
    
    
    
}
