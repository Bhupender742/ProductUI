//
//  ProductModel.swift
//  ProductUI
//
//  Created by Bhupender Rawat on 22/07/21.
//

import Foundation

struct APIResponse: Decodable {
    let data: Result
}

struct Result: Decodable {
    let products: [Product]
}

struct Product: Decodable {
    let name: String
    let price: Price
    let images: [String]
    let review: Review
}

struct Price: Decodable {
    let priceDisplay: String
    let strikeThroughPriceDisplay: String
    let minPrice: String
}

struct Review: Decodable {
    let rating: Int
}
