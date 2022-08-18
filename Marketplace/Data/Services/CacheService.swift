//
//  CacheService.swift
//  Marketplace
//
//  Created by Marcos Vicente on 14/08/22.
//

import Foundation

enum CacheKey: String {
    case products = "com.riverisland.marketplace.products"
}

final class CacheService {

    private static let userDefaults = UserDefaults.standard

    private init() { }

    static func store(_ value: Data, for key: CacheKey) {
        userDefaults.setValue(value, forKey: key.rawValue)
    }

    static func get(for key: CacheKey) -> Data? {
        userDefaults.data(forKey: key.rawValue)
    }
}
