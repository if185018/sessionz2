//
//  FirebaseSttorageService.swift
//  Sessionz2
//
//  Created by C4Q on 6/1/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit
import FirebaseStorage

class FirebaseStorageService {
    private init () {}
    
    static let manager = FirebaseStorageService()
    
    func updateProfileImage(for user: AppUser, image: UIImage, completion: @escaping (Result<String, Error>) -> ()) {
        //success string will be the download url for new image
        
        deleteCurrentProfileImage(for: user)
        
        
        
    }
    
    func deleteCurrentProfileImage(for user: AppUser) {
        guard let profileImageUrl = user.profileImageURL else {
            print("NO profile image for user")
            return}
        STORAGE_REF.child(profileImageUrl).delete(completion: nil)
        //TODO update this and store the image 
        
    }
    
    
}
