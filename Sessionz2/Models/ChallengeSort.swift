//
//  ChallengeSort.swift
//  Sessionz2
//
//  Created by C4Q on 12/7/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//


import UIKit

enum ChallengeStatus: String {
    case all
    case outgoing
    case recieved
    case completed
}

struct ChallengeSort {
    let icon: UIImage
    let type: ChallengeStatus
}
