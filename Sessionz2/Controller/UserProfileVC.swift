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


class UserProfileVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    //MARK: Properties
    var user: AppUser?
    
    
    private let challengePlayerView = ChallengePlayerView()
    private let challengePlayerViewHeight: CGFloat = 300 
    
    
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white 
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        if self.user == nil {
        setCurrentUser()
        }
    }
    
    
    //MARK: TOUCHES
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.challengePlayerView.frame.origin.y == self.view.frame.height - self.challengePlayerViewHeight {
            guard touches.first?.view != challengePlayerView else {return}
            animateChalengePlayerView(shouldShow: false, player: nil)
            
        } else if self.challengePlayerView.frame.origin.y == self.view.frame.height - self.challengePlayerViewHeight {
            guard touches.first?.view != challengePlayerView else {return}
            animateChalengePlayerView(shouldShow: false, player: nil)
        }
    }
    
    
    private func animateChalengePlayerView(shouldShow: Bool, player: AppUser?) {
        if let player = player {
            self.challengePlayerView.user = player
        }
        let yOrigin = shouldShow ? self.view.frame.height - self.challengePlayerViewHeight : self.view.frame.height
        
        UIView.animate(withDuration: 0.3) {
            self.challengePlayerView.frame.origin.y = yOrigin
        }
    }
    
    
    //MARK: UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    //MARK: UICollectionView Data
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        // declare header
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! UserProfileHeader
        
        // set delegate
        header.delegate = self
        
        // set the user in header
        header.user = self.user
        
        
        // return header
        return header
    }

    
    //TODO: Configure This with Match History
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 1
       }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 6
       }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        return cell
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
    func challengeButtonPressed() {
        
    }
    
    func setUserStats(for header: UserProfileHeader) {
        //TODO
    print("Header stats to be displayed")
    }
    
    
}
