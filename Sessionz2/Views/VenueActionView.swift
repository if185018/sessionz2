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
    
    
    
    
    
}
