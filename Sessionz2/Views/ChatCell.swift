//
//  ChatCell.swift
//  Sessionz2
//
//  Created by C4Q on 6/16/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

protocol ChatCellDelegate {
    func handlePlayVideo(for cell: ChatCell)
}

class ChatCell: UICollectionViewCell {
    
    //MARK: Properties
    
       var bubbleWidthAnchor: NSLayoutConstraint?
       var bubbleViewRightAnchor: NSLayoutConstraint?
       var bubbleViewLeftAnchor: NSLayoutConstraint?
       var delegate: ChatCellDelegate?
       var playerLayer: AVPlayerLayer?
       var player: AVPlayer?
    
    
    
    
    
    
    
}
