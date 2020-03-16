//
//  FirebaseDatabaseHelper.swift
//  Sessionz2
//
//  Created by C4Q on 3/13/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseDatabaseHelper {
    private init () {}
    
    static let manager = FirebaseDatabaseHelper()
    
    func uploadCreatedUserToDatabase(uid: String, appUser: AppUser, completion: @escaping (Result<Void, Error>) -> Void) {
        REF_USERS.child(uid).updateChildValues(appUser.fieldsDict) { (error, ref) in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
            
        }
    }
}
