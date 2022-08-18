//
//  NetworkRequestsTests.swift
//  MarketplaceTests
//
//  Created by Marcos Vicente on 16/08/22.
//

import XCTest
@testable import Marketplace

class NetworkRequestsTests: XCTestCase {

    func testProductsListNotEmpty() {
        let productsListManager = ProductsListManagerViewModel(urlString: "") { _ in }
        let url = URL(string: "https://static-ri.ristack-3.nn4maws.net/v1/plp/en_gb/2506/products.json")
        var productModels: [ProductModel] = []

        let expectation = self.expectation(description: "Products request")

        productsListManager.requestProducts(url: url) { result in
            switch result {
            case .success(let products):
                productModels.append(contentsOf: products)
            case .failure: break
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: 6)

        XCTAssertNotEqual(productModels, [])
    }

    func testProductsRequestBadRequest() {
        let productsListManager = ProductsListManagerViewModel(urlString: "") { _ in }
        let url = productsListManager.url
        var resultError: Error? = nil

        let expectation = self.expectation(description: "Products request")

        productsListManager.requestProducts(url: url) { result in
            switch result {
            case .success: break
            case .failure(let error):
                resultError = error
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: 6)

        XCTAssertNotNil(resultError)
    }

    func testSuccessfullImageDownload() {
        let productDetailViewModel = ProductDetailViewModel(productName: "White graphic frill t-shirt", imageUrl: "https://images.riverisland.com/is/image/RiverIsland/760434_main")
        let link = productDetailViewModel.imageUrl
        var resultImage: UIImage? = nil

        let expectation = self.expectation(description: "Image downloading")

        productDetailViewModel.downloadImage(from: link) { result in
            switch result {
            case .success(let image):
                resultImage = image
            case .failure: break
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: 6)

        XCTAssertNotNil(resultImage)
    }

    func testFailedImageDownload() {
        let productDetailViewModel = ProductDetailViewModel(productName: "White graphic frill t-shirt", imageUrl: "http://riverisland.scene7.com/is/image/RiverIsland/760434_main") // Wrong url from task fail

        let link = productDetailViewModel.imageUrl
        var resultImage: UIImage? = nil

        let expectation = self.expectation(description: "Image downloading")

        productDetailViewModel.downloadImage(from: link) { result in
            switch result {
            case .success(let image):
                resultImage = image
            case .failure: break
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: 6)

        XCTAssertNil(resultImage)
    }
}
