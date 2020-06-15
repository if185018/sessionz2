//
//  MessageInputAccessoryView.swift
//  Sessionz2
//
//  Created by C4Q on 6/15/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit


protocol MessageInputAccessoryViewDelegate {
    func handleUploadMessage(message: String)
    func handleSelectImage()
}

class MessageInputAccessoryView: UIView {
    
    //MARK: Properties
    
    var delegate: MessageInputAccessoryViewDelegate?
    
    
    
}
