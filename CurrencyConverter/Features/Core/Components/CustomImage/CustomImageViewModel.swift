//
//  CustomImageViewModel.swift
//  CurrencyConverter
//
//  Created by Ahmed Ali on 10/06/2023.
//

import SwiftUI

class CustomImageViewModel: ObservableObject {
    let url: URL?
    @Published var image: Image? = nil
    let networkService = NetworkService.init()
    
    init(url: URL?) {
        self.url = url
    }
    
    @MainActor
    func loadImage() async {
        if let url {
            if let cachedImage = ImageCacheImpl.shared.getImage(for: url.absoluteString) {
                print("image cachedImage")
                image = cachedImage
            } else {
                do {
                    let data = try await networkService.executeRequest(for: url)
                    if let uiImage = UIImage(data: data) {
                        ImageCacheImpl.shared.saveImage(for: url.absoluteString, image: uiImage)
                        image = Image(uiImage: uiImage)
                        print("image downloaded \(data)")
                    }
                } catch {
                    print("loadImage \(error)")
                }
            }
        }
    }
}
