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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

