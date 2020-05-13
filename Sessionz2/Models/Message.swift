//
//  Message.swift
//  Sessionz2
//
//  Created by C4Q on 5/13/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation
import MessageKit


struct Message: MessageType {
    
    var sender: SenderType {
        return user
    }
    
    var messageId: String
    
    var sentDate: Date
    
    var kind: MessageKind
    
    var user: AppUser
    
    
}
