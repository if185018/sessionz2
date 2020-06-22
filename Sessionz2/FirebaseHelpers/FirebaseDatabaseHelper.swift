//
//  FirebaseDatabaseHelper.swift
//  Sessionz2
//
//  Created by Iram Fattah on 3/13/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation
import FirebaseDatabase

fileprivate let profileImageURLKey = "ProfileImageURL"

class FirebaseDatabaseHelper {
    private init () {}
    
    static let manager = FirebaseDatabaseHelper()
    
    func uploadCreatedUserToDatabase(uid: String, appUser: AppUser, completion: @escaping (Result<Void, Error>) -> Void) {
        REF_USERS.child(uid).updateChildValues(appUser.fieldsDict) { (error, ref) in
            if let error = error {
                completion(.failure(error))
                return
            } else {
                completion(.success(()))
            }
            
        }
    }
    
    func fetchUserData(uid: String, completion: @escaping (Result<AppUser, AppError>) -> Void) {
        REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {
                completion(.failure(.noData))
                return}
            let userID = snapshot.key
            let appUser = AppUser(uid: userID, dictionary: dictionary)
            completion(.success(appUser))
            
        }
    }
    
    
    func updateProfileImageValues(uid: String, newUrlStr: String, completion: @escaping (Result<(), Error>) -> ()) {
        REF_USERS.child(uid).child(profileImageURLKey).setValue(newUrlStr) { (err, ref) in
            if let err = err {
                completion(.failure(err))
            }
                
            else {
                completion(.success(()))
            }
        }
    }
}


//MARK: Message functions
extension FirebaseDatabaseHelper {
    
}
