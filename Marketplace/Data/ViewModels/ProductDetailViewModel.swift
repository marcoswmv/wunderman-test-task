//
//  ProductDetailViewModel.swift
//  Marketplace
//
//  Created by Marcos Vicente on 14/08/22.
//

import Foundation
import UIKit

struct ProductDetailViewModel: Networking {
    let productName: String
    let imageUrl: String

    func setImage(for imageView: UIImageView) {
        downloadImage(from: imageUrl) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    imageView.image = image
                case .failure:
                    break
                }
            }
        }
    }
}
