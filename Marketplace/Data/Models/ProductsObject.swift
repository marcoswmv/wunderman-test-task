//
//  ProductsObject.swift
//  Marketplace
//
//  Created by Marcos Vicente on 13/08/22.
//

import Foundation

struct ProductsObject: Codable, Equatable {
    let products: [ProductModel]

    enum CodingKeys: String, CodingKey {
        case products = "Products"
    }

    static func == (lhs: ProductsObject, rhs: ProductsObject) -> Bool {
        return lhs.products == rhs.products
    }
}
