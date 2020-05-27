//
//  EditProfileViewController.swift
//  Sessionz2
//
//  Created by C4Q on 5/25/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    //MARK: Properties
    var user: AppUser?
    var imageChanged = false
    var usernameChanged = false
    var updatedUsername: String?
    
    //MARK: UI Objects
    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    let changePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change Profile Image", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        //TODO add target for button selection
        return button
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.textAlignment = .left
        tf.borderStyle = .none
        return tf
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.textAlignment = .left
        tf.borderStyle = .none
        tf.isUserInteractionEnabled = false
        return tf
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let gamerTagLabel: UILabel = {
        let label = UILabel()
        label.text = "Gamer Tag"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let fullnameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let usernameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    
    //MARK: Init
    
    init(user: AppUser) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()

        
    }
    
    
    //MARK: SeT Up Methods
    
    private func configureNavigationBar() {
        
        navigationItem.title = "Edit Profile"
        
        navigationController?.navigationBar.tintColor = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(handleDone))
        
    }
    
    private func configureViewComponents() {
        view.backgroundColor = .white
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 150)
        let containerView = UIView(frame: frame)
        containerView.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(containerView)
        
        containerView.addSubview(profileImageView)
        profileImageView.anchor(top: containerView.topAnchor, paddingTop: 16, width: 80, height: 80)
        
        profileImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        profileImageView.layer.cornerRadius = 80 / 2
        
        
        containerView.addSubview(changePhotoButton)
        changePhotoButton.anchor(top: profileImageView.bottomAnchor, paddingTop: 8, width: 0, height: 0)
         changePhotoButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
    }
    
    private func loadUserData() {
        guard let user = self.user else {return}
        
        profileImageView.loadImage(with: user.profileImageURL ?? "")
        
        emailTextField.text = user.email
        gamerTagLabel.text = user.gamerTag
    }
    

   
    
    //MARK: Selectors
    
    @objc func handleCancel() {
        
    }
    
    @objc func handleDone() {
        
    }

}
