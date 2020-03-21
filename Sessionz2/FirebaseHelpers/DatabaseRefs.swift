//
//  DatabaseRefs.swift
//  Sessionz2
//
//  Created by Iram Fattah on 3/9/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation
import Firebase


//MARK: Database References

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
