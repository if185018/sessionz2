//
//  AppUser.swift
//  Sessionz2
//
//  Created by Iram Fattah on 3/9/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation
import CoreLocation
import MessageKit

//Constants
fileprivate let gamerTagKey = "gamerTag"
fileprivate let emailKey = "email"
fileprivate let consoleTypeKey = "consoleType"
fileprivate let uidKey = "uid"
fileprivate let profileImageURLKey = "ProfileImageURL"


enum ConsoleType: Int, CustomStringConvertible {
    var description: String {
        switch self {
        case .PC: return "PC"
        case .PS4: return "PS4"
        case.Xbox: return "Xbox"
        }
    }
    
    case PS4 = 0
    case Xbox = 1
    case PC = 2
}


//conform to sender type for messaging 
struct AppUser: SenderType {
    var senderId: String {
        return self.uid
    }
    
    var displayName: String {
        return self.gamerTag
    }
    
    let gamerTag: String
    let email: String
    var consoleType: ConsoleType!
    var location: CLLocation?
    let uid: String
    var pulsing: Bool?
    var profileImageURL: String?
    
    init(uid: String, gamerTag: String, email: String, consoleType: ConsoleType) {
        self.uid = uid
        self.gamerTag = gamerTag
        self.email = email
        self.consoleType = consoleType
        
    }
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.gamerTag = dictionary[gamerTagKey] as? String ?? ""
        self.email = dictionary[emailKey] as? String ?? ""
        self.profileImageURL = dictionary[profileImageURLKey] as? String ?? ""
        if let consoleIndex = dictionary[consoleTypeKey] as? Int {
            self.consoleType = ConsoleType(rawValue: consoleIndex)
        }
    }
    
    
    var fieldsDict: [String: Any] {
        return [gamerTagKey: self.gamerTag,
                emailKey: self.email,
                consoleTypeKey: self.consoleType.rawValue,
                uidKey: self.uid]
    }
    
}
