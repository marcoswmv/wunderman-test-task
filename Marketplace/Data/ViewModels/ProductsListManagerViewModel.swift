//
//  ProductsListManagerViewModel.swift
//  Marketplace
//
//  Created by Marcos Vicente on 14/08/22.
//

import UIKit

final class ProductsListManagerViewModel: Networking {

    var posts: Observable<[ProductCellViewModel]> = Observable([])

    var url: URL?
    private var handleError: ErrorMessageHandlingBlock

    init(urlString: String, handleError: @escaping ErrorMessageHandlingBlock) {
        self.url = URL(string: urlString)
        self.handleError = handleError
        self.fetch()
    }

    private func fetch() {
        requestProducts(url: url) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case let .success(products):
                products.forEach { product in
                    if let prodId = Int(product.prodId) {
                        let productViewModel: ProductCellViewModel = ProductCellViewModel(id: prodId,
                                                                                          name: product.name,
                                                                                          price: product.cost,
                                                                                          imageUrl: "https://images.riverisland.com/is/image/RiverIsland/\(prodId)_main")
                        if self.posts.value?.contains(where: { model in
                            return model.id == productViewModel.id
                        }) == false {
                            self.posts.value?.append(productViewModel)
                        }
                    }
                }

            case let .failure(error):
                self.handleError(error.localizedDescription)
            }
        }
    }
}
