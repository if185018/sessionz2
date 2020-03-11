//
//  ContainerController.swift
//  Sessionz2
//
//  Created by C4Q on 3/11/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit

class ContainerController: UIViewController {
    
    //MARK: Properties
    private let homeController = HomeController()
    private var menuController: MenuController!
    private var isExpanded = false
    private lazy var xOrigin = self.view.frame.width - 80
    
    
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    //MARK: Helper Methods
    
    private func configureHomeController() {
        addChild(homeController)
        homeController.didMove(toParent: self)
        view.addSubview(homeController.view)
        
    }
    
    
    func configureMenuController(with user: AppUser) {
         menuController = MenuController(user: user)
        menuController.didMove(toParent: self)
        view.insertSubview(menuController.view, at: 0)
        
    }
    
}
