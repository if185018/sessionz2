//
//  ChatController.swift
//  Sessionz2
//
//  Created by C4Q on 6/11/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit
import Firebase
import MobileCoreServices
import AVFoundation

private let reuseIdentifier = "ChatCell"

class ChatController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: Properties
    
    //User that will recieve the message
    var user: AppUser?
    var messages = [Message]()
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    lazy var containerView: MessageInputAccesoryView = {
           let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 60)
           let containerView = MessageInputAccesoryView(frame: frame)
           //containerView.delegate = self
           return containerView
       }()
    
    
    override var inputAccessoryView: UIView? {
        get {
            return containerView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    
    
    
    
    
    //MARK: Setup
    
    
    func configureNavigationBar() {
        guard let user = self.user else {return}
        
        navigationItem.title = user.gamerTag
        
    }
    
    func scrollToBottom() {
        if messages.count > 0 {
            let indexPath = IndexPath(item: messages.count - 1, section: 0)
            collectionView?.scrollToItem(at: indexPath, at: .top, animated: true)
        }
    }
    
    
    
    //MARK: Handlers
    
    @objc func handleInfoTapped() {
        //TO DO: Handle user profile vc
        print("user tapped")
    }
    
    @objc func handleKeyboardDidShow() {
        scrollToBottom()
    }
    
    
    
    
    
    
}

