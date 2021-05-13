//
//  UIImageView+Extension.swift
//  FoodApp
//
//  Created by Alexandra Radu on 13.05.2021.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: String) {
        guard let url = URL(string: url) else {
            print("Nu s-a putut incarca imaginea")
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
}
