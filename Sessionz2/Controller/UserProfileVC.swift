//
//  UserProfileVC.swift
//  Sessionz2
//
//  Created by C4Q on 5/6/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"
private let headerIdentifier = "UserProfileHeader"


class UserProfileVC: UITableViewController {
    
    
    //MARK: Properties
    var user: AppUser?
    
    
    //MARK: Init
    
    init(user: AppUser) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UserProfileHeader.self, forHeaderFooterViewReuseIdentifier: headerIdentifier)
        let header = UserProfileHeader(reuseIdentifier: headerIdentifier)
        header.frame = CGRect(x: 0, y: 0, width: 50, height: 80)
        tableView.tableHeaderView = header
        
        if self.user == nil {
        setCurrentUser()
        }
    }
    
    
    
    //MARK: UITableView DataSource/Delegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
   
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
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

extension UserProfileVC: UserProfileHeaderDelegate {
    func setUserStats(for header: UserProfileHeader) {
        //TODO
    print("Header stats to be displayed")
    }
    
    
}
