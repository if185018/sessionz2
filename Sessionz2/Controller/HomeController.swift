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


class HomeController: UIViewController {
    
    
    //MARK: Properties
    
     private let mapView = MKMapView()
    
    
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

