//
//  ProductModel.swift
//  ProductUI
//
//  Created by Bhupender Rawat on 22/07/21.
//

import Foundation

struct APIResponse: Codable {
    let data: Datum?
}

struct Datum: Codable {
    let products: [Product]?
}

struct Product: Codable {
    let name: String?
    let price: Price?
    let images: [String]?
    let review: Review?
}

struct Price: Codable {
    let priceDisplay: String?
    let strikeThroughPriceDisplay: String?
    let minPrice: Int?
}

struct Review: Codable {
    let rating: Int? 
}
