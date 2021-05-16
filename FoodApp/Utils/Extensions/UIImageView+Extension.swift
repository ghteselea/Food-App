//
//  UIImageView+Extension.swift
//  FoodApp
//
//  Created by Alexandra Radu on 13.05.2021.
//

import Foundation
import UIKit

extension UIImageView {
    func loadWithoutCache(url: String) {
        guard let url = URL(string: url) else {
            print("URL is broken")
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    func load(url: String, placeholder: UIImage? = UIImage(named: "no_image"), cache: URLCache? = nil) {
        
        guard let url = URL(string: url) else {
            print("URL is broken")
            return
        }
        
        let cache = cache ?? URLCache.shared
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            self.image = image
        } else {
            self.image = placeholder
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async() {
                        self.image = image
                    }
                }
            }).resume()
        }
    }
}

