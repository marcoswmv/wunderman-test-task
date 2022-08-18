//
//  NSMutableAttributedStrings+Extension.swift
//  Marketplace
//
//  Created by Marcos Vicente on 14/08/22.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    func bold(_ value: String, size: CGFloat) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: size)
        ]

        self.append(NSAttributedString(string: value, attributes: attributes))

        return self
    }
}
