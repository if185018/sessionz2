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
        
        
        var values: [String:AnyObject] = [toIdKey: uid as AnyObject, fromIdKey: currentUid as AnyObject, creationDateKey: creationDate as AnyObject, acceptedKey: false as AnyObject]
        properties.forEach({values[$0] = $1})
        let challengeRef = REF_CHALLENGES.childByAutoId()
        
        guard let challengeKey = challengeRef.key else {return}
        
        challengeRef.updateChildValues(values) { (error, ref) in
            USER_CHALLENGES_REF.child(currentUid).child(uid).updateChildValues([challengeKey: 1])
            
            
            USER_CHALLENGES_REF.child(uid).child(currentUid).updateChildValues([challengeKey: 1])
            
        }
    }
    
    
    func observeChallanges(partnerId: String?, completion: @escaping(String) -> ()) {
         guard let currentUid = self.currentUid else {return}
        guard let partnerId = partnerId else {return}
        USER_CHALLENGES_REF.child(currentUid).child(partnerId).observe(.childAdded) { (snapshot) in
            let challengeId = snapshot.key
            completion(challengeId)
        }
    }
    
    
    
    
}
