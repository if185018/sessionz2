//
//  LoginVC.swift
//  Sessionz2
//
//  Created by Iram Fattah on 3/4/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit
import GeoFire

class LoginVC: UIViewController {
    
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
    
    private lazy var passwordContainerView: UIView = {
           let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
           view.heightAnchor.constraint(equalToConstant: 50).isActive = true
           return view
       }()
    
    
    private let loginButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    
    let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.secondaryBlueTint]))
        
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    
    
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    //MARK: Selector Methods
    
    
     @objc private func handleShowSignUp() {
        let controller = SignUpVC()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func validateFields() {
        guard emailTextField.hasText, passwordTextField.hasText else {
            self.loginButton.backgroundColor = .greyPorcelain
            self.loginButton.isEnabled = false
            return
        }
        self.loginButton.backgroundColor = .mainBlueTint
        self.loginButton.isEnabled = true
    }
    
    @objc func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {return}
        FirebaseAuthService.manager.loginUser(email: email, password: password) { (result) in
            switch result {
            case .success(let uid):
                let geoFire = GeoFire(firebaseRef: REF_USER_LOCATIONS)
                
                if let location = self.location {
                    geoFire.setLocation(location, forKey: uid)
                }
                FirebaseDatabaseHelper.manager.fetchUserData(uid: uid) { (newResult) in
                    switch newResult {
                    case .success(let appUser):
                        //TODO:change root to container controller
                        print("Successfully logged in user! \(appUser.gamerTag)")
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let sceneDelegate = windowScene.delegate as?  SceneDelegate, let window = sceneDelegate.window else {
                            return
                        }
                        
                        //Transition to Container Controller
                        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                            window.rootViewController = ContainerController(user: appUser)
                            
                        }, completion: nil)
                        
                    case .failure(let error):
                        print(error)
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    
    //UI Methods
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    
    private func configureUI() {
        view.backgroundColor = .secondaryBlueTint
        configureNavigationBar()
        configureTitleLabel()
        configureTextFields()
        configureDontHaveAccountButton()
        
    }
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
               titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
               titleLabel.centerX(inView: view)
    }
    
    private func configureTextFields() {
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   passwordContainerView,
                                                   loginButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 24
        
        view.addSubview(stack)
        stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor,
                     right: view.rightAnchor, paddingTop: 40, paddingLeft: 16,
                     paddingRight: 16)
    }
    
    private func configureDontHaveAccountButton() {
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
    }
    
    
    
}
