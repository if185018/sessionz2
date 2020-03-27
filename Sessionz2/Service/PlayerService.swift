//
//  PlayerService.swift
//  Sessionz2
//
//  Created by C4Q on 3/27/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation

struct PlayerService {
    static let shared = PlayerService()
    func fetchPlayerData(uid: String, completion: @escaping(AppUser) -> Void) {
        REF_USERS.child(uid).observe(.value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            let id = snapshot.key
            let appUser = AppUser(uid: id, dictionary: dictionary)
            completion(appUser)
        }
    }
    
}
