//
//  AppUser.swift
//  Sessionz2
//
//  Created by C4Q on 3/9/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation
import CoreLocation

//Constants
fileprivate let gamerTagKey = "gamerTag"
fileprivate let emailKey = "email"
fileprivate let consoleTypeKey = "consoleType"
fileprivate let uidKey = "uid"


enum ConsoleType: Int {
    case PS4
    case Xbox
    case PC
}


struct AppUser {
    let gamerTag: String
    let email: String
    var consoleType: ConsoleType!
    var location: CLLocation?
    let uid: String
    
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
