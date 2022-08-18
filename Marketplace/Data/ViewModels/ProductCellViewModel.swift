//
//  ProductTableViewCellViewModel.swift
//  Marketplace
//
//  Created by Marcos Vicente on 14/08/22.
//

import UIKit

struct ProductCellViewModel {
    let id: Int
    let name: String
    let price: String
    let imageUrl: String

    func generatePriceAttributedText() -> NSMutableAttributedString {
        NSMutableAttributedString()
            .bold("£" + price, size: Appearance.priceFontSize)
    }
}
