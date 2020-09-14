//
//  VenueActionView.swift
//  Sessionz2
//
//  Created by C4Q on 8/24/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit

protocol VenueActionViewDelegate: class {
    func locationButtonClicked(venue: Venue)
}


class VenueActionView: UIView {
    //MARK: Properties
    
    weak var delegate: VenueActionViewDelegate?
    
    
    var venue: Venue? {
        didSet {
            
        }
    }
    
    private lazy var venueNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var hoursOfOperationView: HoursOfOperationView = {
        let view = HoursOfOperationView()
        return view
    }()
    
    
    private let messageButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .secondaryBlueTint
        button.setTitle("Location", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleLocationButtonClicked), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         self.backgroundColor = .white
        self.hoursOfOperationView.hoursOfOperation = self.venue?.hoursOfOperation
        
        
         addShadow()
        let stack = UIStackView(arrangedSubviews: [venueNameLabel, addressLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fillEqually
        
        //configure stack view with gamer tag and full name labels
        addSubview(stack)
        stack.centerX(inView: self)
        stack.anchor(top: topAnchor, paddingTop: 12)
        
        addSubview(hoursOfOperationView)
        
        
       
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    @objc func handleLocationButtonClicked() {
        guard let venue = venue else {return}
        delegate?.locationButtonClicked(venue: venue)
    }
}
