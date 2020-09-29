//
//  Venue.swift
//  Sessionz2
//
//  Created by C4Q on 7/29/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation
import MapKit
import Contacts

let venueNameKey = "name"
let latKey = "latitude"
let longKey = "longitude"
let streetAddressKey = "streetAddress"


class Results: Codable {
    let results: [Venue]
}


class Venue: NSObject, MKAnnotation, Codable {
    var name: String
    let latitude: Double
    let longitude: Double
    let streetAddress: String
    
    var mapItem: MKMapItem? {
        let addressDict = [CNPostalAddressStreetKey: self.streetAddress]
        let placemark = MKPlacemark(coordinate: self.coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.name
        return mapItem
    }
    
    
        
    
    
    var hoursOfOperation: [HoursOfOperation]?
    
    var title: String? {
        return self.name
    }
    
    var coordinate: CLLocationCoordinate2D {
         return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    
    init?(dict: [String: Any]) {
        guard let venueName = dict[venueNameKey] as? String,
        let lat = dict[latKey] as? Double,
        let long = dict[longKey] as? Double,
        let streetAddress = dict[streetAddressKey] as? String
            else {return nil}
        self.name = venueName
        self.latitude = lat
        self.longitude = long
        self.streetAddress = streetAddress
    }
    
    init(name: String, lat: Double, long: Double, streetAddress: String) {
        self.name = name
        self.latitude = lat
        self.longitude = long
        self.streetAddress = streetAddress
    }
}
