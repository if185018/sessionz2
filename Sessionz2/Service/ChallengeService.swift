//
//  ChallengeService.swift
//  Sessionz2
//
//  Created by C4Q on 11/16/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation
import FirebaseAuth

struct ChallengeService {
    private init() {}
    
    let currentUid = Auth.auth().currentUser?.uid
    static let shared = ChallengeService()
    
    func uploadNewChallange(user: AppUser?, with properties: [String: AnyObject]) {
       guard let currentUid = FirebaseAuthService.manager.currentUser?.uid else { return }
        guard let user = user else {return}
        let creationDate = Int(NSDate().timeIntervalSince1970)
        
        guard let uid = user.uid else { return }
        
        let challengeRef = REF_CHALLENGES.childByAutoId()
    }
}
