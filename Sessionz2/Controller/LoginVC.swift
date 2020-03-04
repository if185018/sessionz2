//
//  LoginVC.swift
//  Sessionz2
//
//  Created by C4Q on 3/4/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    //MARK: Properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "SESSIONZ"
        label.font = UIFont(name: "Thonburi", size: 36)
        label.textColor = UIColor(white: 1, alpha: 0.8)
        return label
    }()
    
    
    private let emailTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Email",
                                       isSecureTextEntry: false)
    }()
    
    private let passwordTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Password",
                                       isSecureTextEntry: true)
    }()
    
    
    
    //MARK: Lifecycle
    
    
    
    
}
