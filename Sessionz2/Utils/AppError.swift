//
//  AppError.swift
//  Sessionz2
//
//  Created by C4Q on 3/18/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation
enum AppError: Error {
    case noData
    case noUser
    case other(error: Error)
    
}
