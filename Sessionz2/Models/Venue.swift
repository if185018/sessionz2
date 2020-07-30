//
//  Venue.swift
//  Sessionz2
//
//  Created by C4Q on 7/29/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation
import MapKit

let venueNameKey = "venueName"
let latKey = "lat"
let longKey = "long"


class Venue: NSObject, MKAnnotation {
    var venueName: String?
    let lat: Double?
    let long: Double?
    
    var coordinate: CLLocationCoordinate2D {
         return CLLocationCoordinate2D(latitude: self.lat, longitude: self.long)
    }
    
    init(dict: [String: Any]) {
        guard let venueName = dict[venueNameKey] as? String,
        let lat = dict[latKey] as? Double,
        let long = dict[longKey] as? Double else {return}
        self.venueName = venueName
        self.lat = lat
        self.long = long
    }
}
