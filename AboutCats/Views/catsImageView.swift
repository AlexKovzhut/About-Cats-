//
//  catsImageView.swift
//  About Cats!
//
//  Created by Alexander Kovzhut on 22.12.2021.
//

import UIKit

class catsImageView: UIImageView {
    func fetchImage(from url: String) {
        guard let imageUrl = URL(string: url) else {
            image = UIImage(systemName: "xmark.app")
            return
        }

        if let cachedImage = getCachedImage(for: imageUrl) {
            image = cachedImage
            return
        }

        ImageManager.shared.getImage(from: imageUrl) { (data, response) in
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }

            self.saveDataToCache(with: data, response: response)
        }
    }

    private func saveDataToCache(with data: Data, response: URLResponse) {
        guard let url = response.url else { return }
        let request = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)

        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }

    private func getCachedImage(for url: URL) -> UIImage? {
        let request = URLRequest(url: url)

        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }

        return nil
    }
}
