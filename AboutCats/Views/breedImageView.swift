//
//  breedImageView.swift
//  About Cats!
//
//  Created by Alexander Kovzhut on 22.12.2021.
//

import UIKit

class BreedImageView: UIImageView {
    // Method for fetch image
    func fetchImage(from url: String) {
        guard let imageUrl = URL(string: url) else {
            image = UIImage(systemName: "xmark.app")
            return
        }

        // Use from the cache
        if let cachedImage = getCachedImage(for: imageUrl) {
            image = cachedImage
            return
        }

        // If not in the cache, then take from the network
        ImageManager.shared.getImage(from: imageUrl) { (data, response) in
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }

            // Save in the cache
            self.saveDataToCache(with: data, response: response)
        }
    }

    private func saveDataToCache(with data: Data, response: URLResponse) {
        // Extract the url address where the picture is located
        guard let url = response.url else { return }
        
        // Q∫uery to find data in the cache
        let request = URLRequest(url: url)
        
        // Create a cached object
        let cachedResponse = CachedURLResponse(response: response, data: data)

        // Query for data in cache
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }

    private func getCachedImage(for url: URL) -> UIImage? {
        // query to find data in the cache
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }

        return nil
    }
}
