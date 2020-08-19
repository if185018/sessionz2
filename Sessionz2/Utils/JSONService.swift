//
//  JSONService.swift
//  Sessionz2
//
//  Created by C4Q on 8/19/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation

struct JSONService {
    static func parsePodcastJSONFile() -> [Venue] {
        let fileName = "Venues"
        let type = "json"
        var venues: [Venue] = []
        if let pathname = Bundle.main.path(forResource: fileName, ofType: type) {
            guard let jsonData = FileManager.default.contents(atPath: pathname) else {
                print("could not access json file")
                return [] }
            do {
                let decoder = JSONDecoder()
                let allResults = try decoder.decode(Results.self, from: jsonData)
                venues = allResults.results
            } catch {
                print("read json error: \(error)")
            }
        }
        return venues
    }
}
