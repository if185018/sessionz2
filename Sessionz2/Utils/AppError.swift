//
//  AppError.swift
//  Sessionz2
//
//  Created by Iram Fattah on 3/18/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation
enum AppError: Error {
    case noData
    case badURL
    case noDataReceived
    case notAnImage
    case noUser
    case other(error: Error)
    case bundlePathError
}
