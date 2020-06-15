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
    
    let messageInputTextView: MessageInputTextView = {
        let tv = MessageInputTextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        return tv
    }()
    
    let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleUploadMessage), for: .touchUpInside)
        return button
    }()
    
    let uploadImageIcon: UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "upload_image_icon ")
        return iv
    }()
    
    
    
    
    
    
    // MARK: - Handlers
    
    @objc func handleUploadMessage() {
        guard let message = messageInputTextView.text else { return }
        delegate?.handleUploadMessage(message: message)
    }
    
    @objc func handleSelectImage() {
        delegate?.handleSelectImage()
    }
}
