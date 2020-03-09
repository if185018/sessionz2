//
//  FirebaseAuthService.swift
//  Sessionz2
//
//  Created by C4Q on 3/9/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseAuthService {
   static let manager = FirebaseAuthService()
    
    private let auth = Auth.auth()
    
    var currentUser: User? {
        return auth.currentUser
    }
    
    
   public func createNewUser(email: String, password: String, completion: @escaping (Result<User,Error>) -> ()) {
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if let createdUser = result?.user {
                completion(.success(createdUser))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
   public func loginUser(email: String, password: String, completion: @escaping (Result<(), Error>) -> ()) {
           auth.signIn(withEmail: email, password: password) { (result, error) in
               if let user = result?.user {
                   completion(.success(()))
               } else if let error = error {
                   completion(.failure(error))
               }
           }
       }
    
    
    func logOutUser(completion: @escaping(Result<(), Error>) -> Void) {
        do {
            try auth.signOut()
            completion(.success(()))
        } catch {
            completion(.failure(error))
            
        }
    }

       private init () {}
    
    
}
