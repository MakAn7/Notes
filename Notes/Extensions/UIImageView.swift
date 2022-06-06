//
//  UIImageView.swift
//  Notes
//
//  Created by Антон Макаров on 06.06.2022.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadedFrom(link: URL?) {
        guard let url = link else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) -> Void in
            guard
                let data = data,
                error == nil,
                let image = UIImage(data: data) else { return }
            DispatchQueue.main.async { () -> Void in
                self.image = image
            }
        }).resume()
    }
}
