//
//  UserProfileVC.swift
//  Sessionz2
//
//  Created by C4Q on 5/6/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit
import Firebase

class UserProfileVC: UITableViewController {
    
    
    //MARK: Properties
    var user: AppUser?
    
    
    
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCurrentUser()
    }
    
    
    //MARK: Firebase API
    
    private func setCurrentUser() {
        guard let currentUserId = FirebaseAuthService.manager.currentUser?.uid else {return}
        FirebaseDatabaseHelper.manager.fetchUserData(uid: currentUserId) { (result) in
            switch result {
            case .success(let user):
                self.user = user
                print("\(user.gamerTag)")
                
            case .failure(let error):
                print(error)
            }
        }
        
            
        
    }
    
    
    
}