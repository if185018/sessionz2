//
//  HomeController.swift
//  Sessionz2
//
//  Created by Iram Fattah on 3/11/20.
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
    
    lazy var mapView: MKMapView = {
        let mv = MKMapView()
        mv.mapType = .standard
        mv.isUserInteractionEnabled = true
        return mv
    }()
    
    private let locationManager = LocationHandler.shared.locationManager
    private var actionButtonConfig = ActionButtonConfiguration()
    
    weak var delegate: HomeControllerDelegate?
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "baseline_menu_black_36dp").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        enableLocationServices()
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
        configureActionButton()
    }
    
    private func configureMapView() {
        view.addSubview(mapView)
        mapView.frame = view.frame
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.delegate = self
    }
    
    private func configureActionButton() {
        view.addSubview(actionButton)
        actionButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,
                            paddingTop: 16, paddingLeft: 20, width: 30, height: 30)
    }
    
    
    
    
    //MARK: Selectors
    
    
    @objc func actionButtonPressed() {
        switch actionButtonConfig {
        case .showMenu:
            print("show menu")
            delegate?.handleMenuToggle()
        case .dismissActionView:
            //TODO: Dismiss action view
            print("dismiss action")
        }
        
    }
    
    
    
}


//MARK: Location Services

extension HomeController {
    private func enableLocationServices() {
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            print("DEBUG: Not determined..")
            locationManager?.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways:
            print("DEBUG: Auth always..")
        case .authorizedWhenInUse:
            print("DEBUG: Auth when in use..")
            locationManager?.startUpdatingLocation()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        @unknown default:
            break
        }
    }
    
    
}

extension HomeController: MKMapViewDelegate {
    
}
