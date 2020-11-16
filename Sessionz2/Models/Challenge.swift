//
//  Challenge.swift
//  Sessionz2
//
//  Created by C4Q on 10/1/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation
let acceptedKey = "accepted"
let matchSetKey = "matchSet"

class Challenge {
    var fromId: String!
    var toId: String!
    var creationDate: Date!
    var accepted: Bool!
    var matchSet: Int!
    
    
    init(dictionary: [String: Any]) {
        if let fromId = dictionary[fromIdKey] as? String {
            self.fromId = fromId
        }
        
        if let toId = dictionary[toIdKey] as? String {
            self.toId = toId
        }
        if let creationDate = dictionary[creationDateKey] as? Double {
            self.creationDate = Date(timeIntervalSince1970: creationDate)
        }
        if let accepted = dictionary[acceptedKey] as? Bool {
            self.accepted = accepted
        }
        if let matchSet = dictionary[matchSetKey] as? Int {
            self.matchSet = matchSet
        }
        
        
    }
}
