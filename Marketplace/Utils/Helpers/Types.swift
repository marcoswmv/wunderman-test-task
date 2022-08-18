//
//  Types.swift
//  Marketplace
//
//  Created by Marcos Vicente on 14/08/22.
//

import UIKit

typealias ErrorMessageHandlingBlock = ((String) -> Void)
typealias ImageRequestCompletionBlock = (Result<UIImage, Error>) -> Void
typealias ProductsResponseBlock = (Result<[ProductModel], Error>) -> Void
