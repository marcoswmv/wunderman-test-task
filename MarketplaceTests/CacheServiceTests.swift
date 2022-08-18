//
//  CacheServiceTests.swift
//  MarketplaceTests
//
//  Created by Marcos Vicente on 16/08/22.
//

import XCTest
@testable import Marketplace

class CacheServiceTests: XCTestCase {

    func testGetProductsFromCache() {
        let productsListManager = ProductsListManagerViewModel(urlString: "") { _ in }
        let url = URL(string: "https://static-ri.ristack-3.nn4maws.net/v1/plp/en_gb/2506/products.json")

        let expectation = self.expectation(description: "Products caching")

        productsListManager.requestProducts(url: url) { result in
            switch result {
            case .success(let products):
                if let data = try? JSONEncoder().encode(products) {
                    CacheService.store(data, for: .products)
                } else {
                    XCTFail("Unsuccessfull encoding")
                }
            case .failure: break
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: 6)

        var productModels: [ProductModel] = []
        if let productsData = CacheService.get(for: .products),
           let products = try? JSONDecoder().decode([ProductModel].self, from: productsData) {
            productModels = products
           }

        XCTAssertNotEqual(productModels, [])
    }

    func testGetImageFromCache() {
        let productDetailViewModel = ProductDetailViewModel(productName: "White graphic frill t-shirt", imageUrl: "https://images.riverisland.com/is/image/RiverIsland/760434_main")
        let link = productDetailViewModel.imageUrl

        let expectation = self.expectation(description: "Image caching")

        productDetailViewModel.downloadImage(from: link) { result in
            switch result {
            case .success(let image):
                ImageCacheService.cache(image: image, for: link)
            case .failure: break
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: 6)

        let resultImage: UIImage? = ImageCacheService.get(for: link)

        XCTAssertNotNil(resultImage)
    }
}
