//
//  PlayerService.swift
//  Sessionz2
//
//  Created by C4Q on 3/27/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation
import CoreLocation
import GeoFire

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
    
    
    func fetchPlayersFromLocation(location: CLLocation, completion: @escaping(AppUser) -> Void) {
        let geofire = GeoFire(firebaseRef: REF_USER_LOCATIONS)
       REF_USER_LOCATIONS.observe(.value) { (snapshot) in
           geofire.query(at: location, withRadius: 50).observe(.keyEntered, with: { (uid, location) in
               PlayerService.shared.fetchPlayerData(uid: uid, completion: { (user) in
                   var driver = user
                   driver.location = location
                   completion(driver)
               })
           })
       }

    }
    
}
