//
//  UserShareIcon.swift
//  Notes
//
//  Created by Антон Макаров on 27.05.2022.
//

import UIKit

class UserShareIconImageView: UIImageView {
    func fetchImage(with url: String?) {
        guard
            let stringUrl = url,
            let imageURl = URL(string: stringUrl) else {
                fatalError("Invalid Image URL")
            }

        if let cachedImage = getCachedImage(with: imageURl) {
            image = cachedImage
            return
        }
        Worker.shared.fetchImage(
            with: imageURl,
            // image опциональное свойство, поэтому weak ставлю в области захвата .
            onSuccess: { [weak self] in
                self?.image = UIImage(data: $0)
                self?.pushDataToCache(with: $0, and: $1)
            },
            onError: { print($0.localizedDescription)
            }
        )
    }

    private func pushDataToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else {
            fatalError("No URL in response")
        }
        let request = URLRequest(url: url)
        let cachedObject = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedObject, for: request)
    }

    private func getCachedImage(with url: URL) -> UIImage? {
        let request = URLRequest(url: url)

        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
}
