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
        button.addTarget(self, action: #selector(handleChangeProfilePhoto), for: .touchUpInside)
        return button
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    
    let gamerTagTextField: UITextField = {
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
        configureViewComponents()
        loadUserData()

        
    }
    
    
    //MARK: SeT Up Methods
    
    private func configureNavigationBar() {
        
        navigationItem.title = "Edit Profile"
        
        navigationController?.navigationBar.tintColor = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(handleDone))
        
    }
    
    func configureViewComponents() {
        
        view.backgroundColor = .white
        
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 150)
        let containerView = UIView(frame: frame)
        containerView.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(containerView)
        
        containerView.addSubview(profileImageView)
        profileImageView.anchor(top: containerView.topAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        profileImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        profileImageView.layer.cornerRadius = 80 / 2
        
        containerView.addSubview(changePhotoButton)
        changePhotoButton.anchor(top: profileImageView.bottomAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        changePhotoButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        containerView.addSubview(separatorView)
        separatorView.anchor(left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        view.addSubview(emailLabel)
        emailLabel.anchor(top: containerView.bottomAnchor, left: view.leftAnchor,  paddingTop: 20, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(gamerTagLabel)
        gamerTagLabel.anchor(top: emailLabel.bottomAnchor, left: view.leftAnchor,  paddingTop: 20, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(emailTextField)
        emailTextField.anchor(top: containerView.bottomAnchor, left: emailLabel.rightAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: (view.frame.width / 1.6), height: 0)
        
        view.addSubview(gamerTagTextField)
        gamerTagTextField.anchor(top: emailTextField.bottomAnchor, left: gamerTagLabel.rightAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: (view.frame.width / 1.6), height: 0)
        
        view.addSubview(fullnameSeparatorView)
        fullnameSeparatorView.anchor(left: emailTextField.leftAnchor, bottom: emailTextField.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -8, paddingRight: 12, width: 0, height: 0.5)
        
        view.addSubview(usernameSeparatorView)
        usernameSeparatorView.anchor(left: gamerTagTextField.leftAnchor, bottom: gamerTagTextField.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -8, paddingRight: 12, width: 0, height: 0.5)
    }
    
    private func loadUserData() {
        guard let user = self.user else {return}
        
        profileImageView.loadImage(with: user.profileImageURL ?? "")
        
        emailTextField.text = user.email
        gamerTagLabel.text = user.gamerTag
    }
    

   
    
    //MARK: Selectors
    
    @objc func handleCancel() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleDone() {
        //handle saving values in text fields
        if imageChanged  {
            updateProfileImage()
        }
        //self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleChangeProfilePhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    

    
    //MARK: API
    
    func updateProfileImage() {
        guard imageChanged else {return}
         guard let user = self.user else { return }
        guard let currentUid = self.user?.uid else {return}
        
        FirebaseStorageService.manager.deleteCurrentProfileImage(for: user)
        
        guard let newImage = self.profileImageView.image else {return}
        
        FirebaseStorageService.manager.updateProfileImage(for: user, image: newImage) { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let profileImageUrl):
                FirebaseDatabaseHelper.manager.updateProfileImageValues(uid: currentUid, newUrlStr: profileImageUrl) { (newResult) in
                    switch newResult {
                    case.success(()):
                        //TODO handle with alert
                        print("successfully updated profile image")
                    case.failure(let error):
                        print(error)
                    }
                }
            }
        }
        
    }
}


//MARK: IMAGE PICKER DELEGATE

extension EditProfileViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        
        if let selectedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage {
            profileImageView.image = selectedImage
            self.imageChanged = true
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}


fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}


fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
