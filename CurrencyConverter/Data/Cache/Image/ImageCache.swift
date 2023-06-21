//
//  LocalImageCache.swift
//  CurrencyConverter
//
//  Created by Ahmed Ali on 10/06/2023.
//

import SwiftUI

// This is a protocol called 'ImageCache' that defines methods for caching images.
protocol ImageCache {
    //  Saves the image provided in the 'image' parameter for the specified 'key'.
    // The 'key' parameter is a string identifier for the image.
    func saveImage(for key: String, image: UIImage)
    
    // Retrieves the cached image for the specified 'key'.
    // The 'key' parameter is a string identifier for the image.
    // The return value is an optional 'Image' object representing the cached image.
    func getImage(for key: String) -> Image?
}
