//
//  PlayerAnnotation.swift
//  Sessionz2
//
//  Created by C4Q on 3/26/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import MapKit

class PlayerAnnotation: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    
    var uid: String
    
    init(uid: String, coordinate: CLLocationCoordinate2D) {
        self.uid = uid
        self.coordinate = coordinate
    }
    
    func updateAnnotationPosition(withCoordinate coordinate: CLLocationCoordinate2D) {
        UIView.animate(withDuration: 0.2) {
            self.coordinate = coordinate
        }
    }
     
}
