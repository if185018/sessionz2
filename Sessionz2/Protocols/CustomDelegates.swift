//
//  CustomDelegates.swift
//  Sessionz2
//
//  Created by C4Q on 3/21/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation

//MARK: Home Controleller Delegate
protocol HomeControllerDelegate: class {
    func handleMenuToggle()
}


protocol MenuControllerDelegate: class {
    func didSelect(option: MenuOptions)
}
