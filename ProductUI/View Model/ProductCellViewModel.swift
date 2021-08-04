//
//  ProductCellViewModel.swift
//  ProductUI
//
//  Created by Bhupender Rawat on 04/08/21.
//

import UIKit

class ProductCellViewModel: NSObject {
    
    public let productImageURL: String
    public let productName: String
    public let productPrice: String
    public let productStrikedPrice: String
    public let productMinPrice: Int
        
    public init(with model: Product) {
        productImageURL = model.images?[0] ?? ""
        productName = model.name ?? ""
        productPrice = model.price?.priceDisplay ?? ""
        productStrikedPrice = model.price?.strikeThroughPriceDisplay ?? ""
        productMinPrice = model.price?.minPrice ?? 0
        }
    
}
