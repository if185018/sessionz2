//
//  HomeController.swift
//  Sessionz2
//
//  Created by C4Q on 3/11/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit
import Firebase
import MapKit


private enum ActionButtonConfiguration {
    case showMenu
    case dismissActionView
    
    init() {
        self = .showMenu
    }
}

class HomeController: UIViewController {
    
    
    //MARK: Properties
    
    private let mapView = MKMapView()
    private let locationManager = LocationHandler.shared.locationManager
    private var actionButtonConfig = ActionButtonConfiguration()
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "baseline_menu_black_36dp").withRenderingMode(.alwaysOriginal), for: .normal)
        //button.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    
    //MARK: Helper Methods
    
    private func configureActionButton(config: ActionButtonConfiguration) {
        switch config {
               case .showMenu:
                   self.actionButton.setImage(#imageLiteral(resourceName: "baseline_menu_black_36dp").withRenderingMode(.alwaysOriginal), for: .normal)
                   self.actionButtonConfig = .showMenu
               case .dismissActionView:
                   actionButton.setImage(#imageLiteral(resourceName: "baseline_arrow_back_black_36dp").withRenderingMode(.alwaysOriginal), for: .normal)
                   actionButtonConfig = .dismissActionView
               }
    }
    
    
    
    //MARK: UI Configurations
    
    
    private func configureUI() {
        configureMapView()
    }
    
    private func configureMapView() {
        view.addSubview(mapView)
               mapView.frame = view.frame
               mapView.showsUserLocation = true
               mapView.userTrackingMode = .follow
               //TODO: Set MapView Delegate to self
               //mapView.delegate = self
    }
    
    
    
    
}

