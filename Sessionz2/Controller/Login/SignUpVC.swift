//
//  SignUpVC.swift
//  Sessionz2
//
//  Created by Iram Fattah on 3/6/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit
import GeoFire

class SignUpVC: UIViewController {
    
    //MARK: Properties
    
    private var location = LocationHandler.shared.locationManager.location
    
    
    private lazy var titleLabel: UILabel = {
           let label = UILabel()
           label.text = "SESSIONZ"
           label.font = UIFont(name: "Thonburi", size: 36)
           label.textColor = UIColor(white: 1, alpha: 0.8)
           return label
       }()
    
    
    private let emailTextField: UITextField = {
        
        let tf = UITextField().textField(withPlaceholder: "Email",
                                       isSecureTextEntry: false)
        tf.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        return tf
    }()
    
    private let gamerTagTextField: UITextField = {
        
        let tf = UITextField().textField(withPlaceholder: "Gamer Tag",
                                       isSecureTextEntry: false)
        tf.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField().textField(withPlaceholder: "Password",
                                       isSecureTextEntry: true)
        tf.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        return tf
    }()
    
    
    private lazy var emailContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var gamerTagContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: gamerTagTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var consoleContainerView: UIView = {
           let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_account_box_white_2x"),
                                                  segmentedControl: consoleSegmentedControl)
           view.heightAnchor.constraint(equalToConstant: 80).isActive = true
           return view
       }()
    
    
    private let consoleSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["PS4", "Xbox", "PC"])
        sc.backgroundColor = .backgroundColor
        sc.tintColor = UIColor(white: 1, alpha: 0.87)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    
    private let signUpButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    
    lazy var alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already Have An Account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: "Sign In", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.secondaryBlueTint]))
        
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    //MARK: Lifeycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    //MARK: Objc Selector Methods
    
    @objc private func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleSignUp() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let gamerTag = gamerTagTextField.text else {return}
        
       let consoleTypeIndex = consoleSegmentedControl.selectedSegmentIndex
       let consoleType = ConsoleType(rawValue: consoleTypeIndex)!
        
        
        
        FirebaseAuthService.manager.createNewUser(email: email, password: password) {result in
            switch result {
            case .success(let user):
                let appUser = AppUser(uid: user.uid, gamerTag: gamerTag, email: email, consoleType: consoleType)
                FirebaseDatabaseHelper.manager.uploadCreatedUserToDatabase(uid: appUser.uid, appUser: appUser) { (result) in
                    switch result {
                    case .success():
                        
                       let geoFire = GeoFire(firebaseRef: REF_USER_LOCATIONS)

                       if let location = self.location {
                            geoFire.setLocation(location, forKey: appUser.uid)
                       }
                       
                        
                        //TODO:change root to container controller
                        print("sucessfully created user and signed in")
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let sceneDelegate = windowScene.delegate as?  SceneDelegate, let window = sceneDelegate.window else {
                            return
                        }
                        
                        //Transition to Container Controller
                        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                            window.rootViewController = ContainerController(user: appUser)
                            
                        }, completion: nil)
                        
                    case .failure(let error):
                        //TODO: show error message
                        print("error creating user \(error)")
                        
                    }
                }
            case.failure(let error):
                print(error)
            }
        }
    }
    
    @objc func validateFields() {
        guard emailTextField.hasText, passwordTextField.hasText, gamerTagTextField.hasText else {
            self.signUpButton.backgroundColor = .greyPorcelain
            self.signUpButton.isEnabled = false
            return
        }
        self.signUpButton.backgroundColor = .mainBlueTint
        self.signUpButton.isEnabled = true
        
    }
    
    
    //UI Setup Methods
    
    private func configureUI() {
        view.backgroundColor = .secondaryBlueTint
        configureTitleLabel()
        configureStackView()
        configureAlreadyHaveAccountButton()
    }
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
               titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
               titleLabel.centerX(inView: view)
    }
    
    private func configureStackView() {
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                          gamerTagContainerView,
                                                          passwordContainerView,
                                                          consoleContainerView,
                                                          signUpButton])
               stack.axis = .vertical
               stack.distribution = .fillProportionally
               stack.spacing = 24
               
               view.addSubview(stack)
               stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor,
                            right: view.rightAnchor, paddingTop: 40, paddingLeft: 16,
                            paddingRight: 16)
    }
    
    private func configureAlreadyHaveAccountButton() {
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
    }
    
}
