//
//  NetworkService.swift
//  Marketplace
//
//  Created by Marcos Vicente on 13/08/22.
//

import UIKit

private enum NetworkResult<Error> {
    case success
    case failure(Error)
}

private enum NetworkResponse: Error {
    case success
    case badRequest
    case outdated
    case failed
    case unableToDecode(description: String)
}

protocol Networking { }

extension Networking {
    func requestProducts(url: URL?, _ completionHandler: @escaping ProductsResponseBlock) {
        NetworkService.shared.requestProducts(url: url, completionHandler)
    }

    @discardableResult
    func downloadImage(from url: URL, _ completionHandler: @escaping ImageRequestCompletionBlock) -> URLSessionDataTask? {
        NetworkService.shared.downloadImage(from: url, completionHandler)
    }

    @discardableResult
    func downloadImage(from link: String, _ completionHandler: @escaping ImageRequestCompletionBlock) -> URLSessionDataTask? {
        NetworkService.shared.downloadImage(from: link, completionHandler)
    }
}

private class NetworkService {

    static let shared = NetworkService()

    private init() { }

    private func handleNetworkResponse(_ response: HTTPURLResponse) -> NetworkResult<Error> {
        switch response.statusCode {
        case 200...299 : return .success
        case 501...599 : return .failure(NetworkResponse.badRequest)
        case 600 : return .failure(NetworkResponse.outdated)
        default: return .failure(NetworkResponse.failed)
        }
    }
}

extension NetworkService {
    func requestProducts(url: URL?, _ completionHandler: @escaping ProductsResponseBlock) {
        guard let url = url else {
            completionHandler(.failure(NetworkResponse.badRequest))
            return
        }

        var cachedResponse: ProductsObject? = nil

        if let unwrappedCacheResponse = CacheService.get(for: .products) {
            do {
                let decodedCachedResponse = try JSONDecoder().decode(ProductsObject.self, from: unwrappedCacheResponse)
                cachedResponse = decodedCachedResponse
                completionHandler(.success(decodedCachedResponse.products))
            } catch {
                completionHandler(.failure(error))
            }
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }

            if let error = error {
                completionHandler(.failure(error))
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)

                switch result {
                case .success:
                    if let data = data {
                        do {
                            let productsResponse = try JSONDecoder().decode(ProductsObject.self, from: data)
                            let products = productsResponse.products
                            CacheService.store(data, for: .products)
                            if cachedResponse != productsResponse {
                                completionHandler(.success(products))
                            }
                        } catch {
                            completionHandler(.failure(NetworkResponse.unableToDecode(description: error.localizedDescription)))
                        }
                    }
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
        }
        task.resume()
    }
}

// MARK: - Image download service
extension NetworkService {
    @discardableResult
    func downloadImage(from url: URL, _ completionHandler: @escaping ImageRequestCompletionBlock) -> URLSessionDataTask? {

        var cachedResponse: UIImage? = nil

        if let cachedImage = ImageCacheService.get(for: url.absoluteString) {
            cachedResponse = cachedImage
            completionHandler(.success(cachedImage))
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }

            if let error = error {
                completionHandler(.failure(error))
            }

            if let response = response as? HTTPURLResponse,
               let mimeType = response.mimeType, mimeType.hasPrefix("image") {
                let result = self.handleNetworkResponse(response)

                switch result {
                case .success:
                    if let data = data,
                       let imageResponse = UIImage(data: data) {
                        ImageCacheService.cache(image: imageResponse, for: url.absoluteString)
                        if cachedResponse != imageResponse {
                            completionHandler(.success(imageResponse))
                        }
                    }

                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
        }
        task.resume()
        
        return task
    }

    @discardableResult
    func downloadImage(from link: String, _ completionHandler: @escaping ImageRequestCompletionBlock) -> URLSessionDataTask? {
        guard let url = URL(string: link) else { return nil }
        return downloadImage(from: url, completionHandler)
    }
}
