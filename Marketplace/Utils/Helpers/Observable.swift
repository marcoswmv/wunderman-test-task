//
//  Observable.swift
//  Marketplace
//
//  Created by Marcos Vicente on 13/08/22.
//

import Foundation

final class Observable<T> {
    var value: T? {
        didSet {
            self.listener?(value)
        }
    }

    private var listener: ((T?) -> Void)?

    init(_ value: T?) {
        self.value = value
    }

    func bind(_ handler: @escaping (T?) -> Void) {
        handler(value)
        self.listener = handler
    }
}
