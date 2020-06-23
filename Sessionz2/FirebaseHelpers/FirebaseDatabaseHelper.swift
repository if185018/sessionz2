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
    
    func uploadMessage(user: AppUser?, with properties: [String:AnyObject]) {
        guard let currentUid = FirebaseAuthService.manager.currentUser?.uid else { return }
        guard let user = user else {return}
        
        let creationDate = Int(NSDate().timeIntervalSince1970)
        
        guard let uid = user.uid else { return }
        
        var values: [String: AnyObject] = [toIdKey: uid as AnyObject, fromIdKey: currentUid as AnyObject, creationDateKey : creationDate as AnyObject, readKey: false as AnyObject]
         properties.forEach({values[$0] = $1})
        
        let messageRef = REF_MESSAGES.childByAutoId()
        
        guard let messageKey = messageRef.key else {return}
        
        messageRef.updateChildValues(values) { (err, ref) in
            USER_MESSAGES_REF.child(currentUid).child(uid).updateChildValues([messageKey: 1])
            
            USER_MESSAGES_REF.child(uid).child(currentUid).updateChildValues([messageKey: 1])
        }
        
    }
}
