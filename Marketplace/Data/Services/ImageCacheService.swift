//
//  ImageCacheService.swift
//  Marketplace
//
//  Created by Marcos Vicente on 14/08/22.
//

import UIKit

final class ImageCacheService {

    private static let cache = NSCache<NSString, UIImage>()
    private var observer: NSObjectProtocol?

    private init() {
        //Release cache on memory pressure
        observer = NotificationCenter.default.addObserver(forName: UIApplication.didReceiveMemoryWarningNotification,
                                                          object: nil,
                                                          queue: nil) { notification in
            ImageCacheService.cache.removeAllObjects()
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(observer!)
    }

    static func get(for key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

    static func cache(image: UIImage, for key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
