//
//  CustomImageView.swift
//  Sessionz2
//
//  Created by C4Q on 5/26/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit

var imageCache = [String: UIImage]()

class CustomImageView: UIImageView {
    
    var lastImgUrlUsedToLoadImage: String?
    
    
    func loadImage(with urlString: String) {
        self.image = nil
        
        lastImgUrlUsedToLoadImage = urlString
        
        
        // check if image exists in cache
        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
        
        // handle error
        if let error = error {
            print("Failed to load image with error", error.localizedDescription)
        }
        
            if self.lastImgUrlUsedToLoadImage != url.absoluteString {
                return
            }
            
            // image data
            guard let imageData = data else { return }
            
            // create image using image data
            let photoImage = UIImage(data: imageData)
            
            // set key and value for image cache
            imageCache[url.absoluteString] = photoImage
            
            // set image
            DispatchQueue.main.async {
                self.image = photoImage
            }
        }.resume()
    }
    
}
