//
//  ImageCacheImpl.swift
//  CurrencyConverter
//
//  Created by Ahmed Ali on 10/06/2023.
//

import SwiftUI

class ImageCacheImpl: ImageCache {
    static let shared = ImageCacheImpl()
    private init() {}
    
    private var cache = NSCache<NSString, UIImage>()
}

extension ImageCacheImpl {
    //  Saves the image provided in the 'image' parameter for the specified 'key'.
    // The 'key' parameter is a string identifier for the image.
    func saveImage(for key: String, image: UIImage) {
        cache.setObject(image, forKey: key.asNSString)
    }
    
    // Retrieves the cached image for the specified 'key'.
    // The 'key' parameter is a string identifier for the image.
    // The return value is an optional 'Image' object representing the cached image.
    func getImage(for key: String) -> Image? {
        if let image = cache.object(forKey: key.asNSString) {
            return Image(uiImage: image)
        }
        return nil
    }
}
