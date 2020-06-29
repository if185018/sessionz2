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
         //TODO update this and store the image
        let filename = NSUUID().uuidString
        
        guard let imageData = image.jpegData(compressionQuality: 0.3) else {return}
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        STORAGE_PROFILE_IMAGES_REF.child(filename).putData(imageData, metadata: metadata) { (metadata, error) in
            if let error = error {
                print("Failed to upload image to storage with error: ", error.localizedDescription)
                completion(.failure(error))
            }
            
            
            STORAGE_PROFILE_IMAGES_REF.child(filename).downloadURL { (url, error) in
                if let error = error {
                    completion(.failure(error))
                } else if let url = url {
                    completion(.success(url.absoluteString))
                }
                
            }
            
        }
        
        
    }
    
    func deleteCurrentProfileImage(for user: AppUser) {
        guard let profileImageUrl = user.profileImageURL else {
            print("NO profile image for user")
            return}
        STORAGE_REF.child(profileImageUrl).delete(completion: nil)
       
        
        
        
    }
    
    
}

//MARK: Message uploads
extension FirebaseStorageService {
    func uploadMessageImageToStorage(image: UIImage, completion: @escaping (Result<String, Error>) -> ()) {
        guard let uploadData = image.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        let ref = STORAGE_MESSAGE_IMAGES_REF.child(filename)
        
        ref.putData(uploadData, metadata: metadata) { (metadata, error) in
            if let error = error {
                 print("DEBUG: Unable to upload image to Firebase Storage")
                completion(.failure(error))
                return
            }
            ref.downloadURL { (url, error) in
                if let error = error {
                    completion(.failure(error))
                } else if let url = url {
                    completion(.success(url.absoluteString))
                }
            }
        }
        
    }
    
    
    func uploadVideoToStorage(with url: URL, completion: @escaping (Result<String, Error>) -> ()) {
        let filename = NSUUID().uuidString
        
        // UPDATE: - Created constant for ref to work with Firebase 5
        let ref = STORAGE_MESSAGE_VIDEO_REF.child(filename)
        
        ref.putFile(from: url, metadata: nil) { (mettadata, error) in
            if let error = error {
                completion(.failure(error))
                return
                
            }
            
            ref.downloadURL { (url, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                if let url = url {
                    completion(.success(url.absoluteString))
                }
            }
        }
    }
    
    
}
