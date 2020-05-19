//
//  MessagePhoto.swift
//  Sessionz2
//
//  Created by C4Q on 5/19/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation
import MessageKit

struct MessagePhoto: MediaItem {
    var url: URL?
    
    var image: UIImage?
    
    var placeholderImage: UIImage
    
    var size: CGSize
    
    init(image: UIImage) {
        self.image = image
        self.url = nil
        self.size = CGSize(width: 100, height: 100)
        self.placeholderImage = image
    }
    
    
}
