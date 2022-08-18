//
//  UIViewController+Extension.swift
//  Marketplace
//
//  Created by Marcos Vicente on 14/08/22.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(with message: String) {
        let alert = UIAlertController(title: Text.errorAlertTitle, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Text.errorAlertButtonTitle, style: .default)

        alert.addAction(okAction)

        present(alert, animated: true)
    }
}
