//
//  ProductModel.swift
//  Marketplace
//
//  Created by Marcos Vicente on 13/08/22.
//

import Foundation

struct ProductModel: Codable, Equatable {
    let prodId: String
    let name: String
    let cost: String

    enum CodingKeys: String, CodingKey {
        case prodId = "prodid"
        case name, cost
    }

    static func == (lhs: ProductModel, rhs: ProductModel) -> Bool {
        return lhs.prodId == rhs.prodId &&
        lhs.name == rhs.name &&
        lhs.cost == rhs.cost
    }
}
