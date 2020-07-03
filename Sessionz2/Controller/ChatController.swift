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
    
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView?.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 16, right: 0)
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(ChatCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.keyboardDismissMode = .interactive
        configureNavigationBar()
        configureKeyboardObservers()
        observeMessages()
        
    }
    
    
    
    //MARK: Setup
    
    
    func configureNavigationBar() {
        guard let user = self.user else {return}
        
        navigationItem.title = user.gamerTag
        let infoButton = UIButton(type: .infoLight)
        infoButton.tintColor = .black
        infoButton.addTarget(self, action: #selector(handleInfoTapped), for: .touchUpInside)
        let infoBarButtonItem = UIBarButtonItem(customView: infoButton)
        
        navigationItem.rightBarButtonItem = infoBarButtonItem
        
    }
    
    func scrollToBottom() {
        if messages.count > 0 {
            let indexPath = IndexPath(item: messages.count - 1, section: 0)
            collectionView?.scrollToItem(at: indexPath, at: .top, animated: true)
        }
    }
    
    func estimateFrameForText(_ text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
    }
    
    func configureKeyboardObservers() {
        func configureKeyboardObservers() {
            NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        }
    }
    
    
    func configureMessage(cell: ChatCell, message: Message) {
         guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        if let messageText = message.messageText {
            cell.bubbleWidthAnchor?.constant = estimateFrameForText(messageText).width + 32
            cell.frame.size.height = estimateFrameForText(messageText).height + 20
            cell.messageImageView.isHidden = true
            cell.textView.isHidden = false
            cell.bubbleView.backgroundColor  = UIColor.rgb(red: 0, green: 137, blue: 249)
        }
        else if let messageImageUrl = message.imageUrl {
            cell.bubbleWidthAnchor?.constant = 200
            cell.messageImageView.loadImage(with: messageImageUrl)
            cell.messageImageView.isHidden = false
            cell.textView.isHidden = true
            cell.bubbleView.backgroundColor = .clear
        }
        
        if message.videoUrl != nil {
            guard let videoUrlString = message.videoUrl else { return }
            guard let videoUrl = URL(string: videoUrlString) else { return }
            
            player = AVPlayer(url: videoUrl)
            cell.player = player
            
            playerLayer = AVPlayerLayer(player: player)
            cell.playerLayer = playerLayer
            
            cell.playButton.isHidden = false
        } else {
            cell.playButton.isHidden = true
        }
        
        if message.fromId == currentUid {
            cell.bubbleViewRightAnchor?.isActive = true
            cell.bubbleViewLeftAnchor?.isActive = false
            cell.textView.textColor = .white
            cell.profileImageView.isHidden = true
        } else {
            cell.bubbleViewRightAnchor?.isActive = false
            cell.bubbleViewLeftAnchor?.isActive = true
            cell.bubbleView.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
            cell.textView.textColor = .black
            cell.profileImageView.isHidden = false
        }
    }
    
    
    func thumbnailImage(for fileUrl: URL) -> UIImage? {
        let asset = AVAsset(url: fileUrl)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let time = CMTimeMake(value: 1, timescale: 60)
            let thumbnailCGImage = try imageGenerator.copyCGImage(at: time, actualTime: nil)
            return UIImage(cgImage: thumbnailCGImage)
        }
        catch {
             print("DEBUG: Exception error: ", error)
        }
        return nil
    }
    
    //MARK: API
    
    func observeMessages() {
        MessageService.shared.observeMessages(chatPartnerId: self.user?.uid) { (messageId) in
            MessageService.shared.fetchMessage(with: messageId) { (message) in
                self.messages.append(message)
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    let indexPath = IndexPath(item: self.messages.count - 1, section: 0)
                    self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
                    
                }
                MessageService.shared.setMessageToRead(for: messageId, fromId: message.fromId)
            }
        }
    }
    
    func sendMessage(imageUrl: String, image: UIImage) {
        let properties = [imageUrlKey: imageUrl, imageWidthKey: image.size.width as Any, imageHeightKey: image.size.height as Any] as [String: AnyObject]
        guard let toUserId = self.user?.uid else {return}
        guard let fromUserId = Auth.auth().currentUser?.uid else {return}
        MessageService.shared.uploadMessage(user: self.user, with: properties, text: nil)
       
        
        MessageService.shared.uploadMessageNotification(type: .Image, text: nil, toId: toUserId, fromId: fromUserId)
    
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

extension ChatController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let videoUrl = info[.mediaURL] as? URL {
            FirebaseStorageService.manager.uploadVideoToStorage(with: videoUrl) { (result) in
                switch result {
                case .success(let url):
                    print(url)
                case .failure(let error):
                    print(error)
                }
            }
        } else if let selectedImage = info[.editedImage] as? UIImage {
            FirebaseStorageService.manager.uploadMessageImageToStorage(image: selectedImage) { (result) in
                switch result {
                case .success(let imageUrl):
                    self.sendMessage(imageUrl: imageUrl, image: selectedImage)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    
}

extension ChatController: MessageInputAccessoryViewDelegate {
    func handleUploadMessage(message: String) {
        let properties = [messageTextKey: message] as [String : AnyObject]
        
        MessageService.shared.uploadMessage(user: self.user, with: properties, text: message)
         self.containerView.clearMessageTextView()
    }
    
    func handleSelectImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String]
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    
}
