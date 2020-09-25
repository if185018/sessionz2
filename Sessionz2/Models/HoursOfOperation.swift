//
//  HoursOfOperation.swift
//  Sessionz2
//
//  Created by C4Q on 8/28/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation

enum DaysOfWeek: String,Codable {
    case Sunday
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    
    
}

struct HoursOfOperation: Codable {
    
    let day: DaysOfWeek
    let openTime: Int?
    let closeTime: Int?
    let weekday: Int
    
   
    
    func generateDisplayText() -> String {
        let calendar = Calendar.current
        let schedule = DateInterval(start: calendar.date(from: DateComponents(hour: openTime, weekday: weekday))!, end: calendar.date(from: DateComponents(hour: closeTime, weekday: weekday))!)
        
        let formatter = DateIntervalFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        
        let output = formatter.string(from: schedule)
        
        return "\(self.day.rawValue): \(output!)"
    }
    
    
    
    
}
