//
//  MatchResult.swift
//  Sessionz2
//
//  Created by C4Q on 10/2/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation

enum MatchSet: Int {
    case firstToTwo = 2
    case firstToThree = 3
    case firstToFive = 5
    case firstToTen = 10
    
}

struct MatchResult {
    var matchSet: MatchSet
    var player1Id: String
    var player2id: String
    var player1Score: Int
    var player2Score: Int
    //var challenge: Challenge
}
