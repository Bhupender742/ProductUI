//
//  ProductModel.swift
//  ProductUI
//
//  Created by Bhupender Rawat on 22/07/21.
//

import Foundation

struct APIResponse: Codable {
    let data: Datum?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(Datum.self, forKey: .data)
    }
    
}

struct Datum: Codable {
    let products: [Product]?
    
    enum CodingKeys: String, CodingKey {
        case products
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        products = try values.decodeIfPresent([Product].self, forKey: .products)
    }
}

struct Product: Codable {
    let name: String?
    let price: Price?
    let images: [String]?
    let review: Review?
    
    enum CodingKeys: String, CodingKey {
        case name
        case price
        case images
        case review
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        price = try values.decodeIfPresent(Price.self, forKey: .price)
        images = try values.decodeIfPresent([String].self, forKey: .images)
        review = try values.decodeIfPresent(Review.self, forKey: .review)
    }
    
}

struct Price: Codable {
    let priceDisplay: String?
    let strikeThroughPriceDisplay: String?
    let minPrice: Int?
    
    enum CodingKeys: String, CodingKey {
        case priceDisplay
        case strikeThroughPriceDisplay
        case minPrice
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        priceDisplay = try values.decodeIfPresent(String.self, forKey: .priceDisplay)
        strikeThroughPriceDisplay = try values.decodeIfPresent(String.self, forKey: .strikeThroughPriceDisplay)
        minPrice = try values.decodeIfPresent(Int.self, forKey: .minPrice)
    }
    
}

struct Review: Codable {
    let rating: Int?
    
    enum CodingKeys: String, CodingKey {
        case rating
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rating = try values.decodeIfPresent(Int.self, forKey: .rating)
    }
    
}
