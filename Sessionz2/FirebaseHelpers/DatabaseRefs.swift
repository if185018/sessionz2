//
//  DatabaseRefs.swift
//  Sessionz2
//
//  Created by Iram Fattah on 3/9/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage


//MARK: Database References

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_USER_LOCATIONS = DB_REF.child("user-locations")
let REF_MESSAGES = DB_REF.child("messages")
let USER_MESSAGES_REF = DB_REF.child("user-messages")
let USER_MESSAGE_NOTIFICATIONS_REF = DB_REF.child("user-message-notifications")
let NOTIFICATIONS_REF = DB_REF.child("notifications")


//MARK: Storage References

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES_REF = STORAGE_REF.child("profile_images")

