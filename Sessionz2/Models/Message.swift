//
//  Message.swift
//  Sessionz2
//
//  Created by C4Q on 6/9/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation
import Firebase

fileprivate let messageTextKey = "messageText"
fileprivate let fromIdKey = "FromId"
fileprivate let toIdKey = "ToId"
fileprivate let creationDateKey = "creationDate"
fileprivate let imageUrlKey = "imageUrl"
fileprivate let imageHeightKey = "imageHeight"
fileprivate let imageWidthKey = "imageWidth"
fileprivate let videoUrlKey = "videoUrl"
fileprivate let readKey = "read"



class Message {
    var messageText: String!
    var fromId: String!
    var toId: String!
    var creationDate: Date!
    var imageUrl: String?
    var imageHeight: NSNumber?
    var imageWidth: NSNumber?
    var videoUrl: String?
    var read: Bool!
    
    
    
    init(dictionary: [String: Any]) {
        if let messageText = dictionary[messageTextKey] as? String {
            self.messageText = messageText
        }
        
        if let fromId = dictionary[fromIdKey] as? String {
            self.fromId = fromId
        }
        
        if let toId = dictionary[toIdKey] as? String {
            self.toId = toId
        }
        
        if let creationDate = dictionary[creationDateKey] as? Double {
            self.creationDate = Date(timeIntervalSince1970: creationDate)
        }
        
        if let imageUrl = dictionary[imageUrlKey] as? String {
            self.imageUrl = imageUrl
        }
        
        if let imageHeight = dictionary[imageHeightKey] as? NSNumber {
            self.imageHeight = imageHeight
        }
        
        if let imageWidth = dictionary[imageWidthKey] as? NSNumber {
            self.imageWidth = imageWidth
        }
        
        if let videoUrl = dictionary[videoUrlKey] as? String {
            self.videoUrl = videoUrl
        }
        
        if let read = dictionary[readKey] as? Bool {
            self.read = read
        }
        
    
    }
    
    
    
    func getChatPartnerId() -> String {
        guard let currentUid = Auth.auth().currentUser?.uid else { return ""}
        
        if fromId == currentUid {
            return toId
        } else {
            return fromId
        }
    }
    
    
    
}
