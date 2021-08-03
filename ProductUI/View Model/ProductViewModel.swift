//
//  ProductViewModel.swift
//  ProductUI
//
//  Created by Bhupender Rawat on 02/08/21.
//

import UIKit

class ProductViewModel: NSObject {
    
    private let urlString = "https://www.blibli.com/backend/search/products?searchTerm=Samsung&start=0&itemPerPage=10"
    
    public var productList = [Product]()
    
    public func fetchProducts(completion: @escaping () -> Void) {
        NetworkManager<APIResponse>().fetchData(from: urlString) { (result) in
                    self.productList = result.data?.products ?? []
                    completion()
        }
    }
    
}

extension ProductViewModel {
    
    public func numberOfRowsInSection() -> Int {
        return productList.count
    }
    
    public func getImageURL(indexPath: IndexPath) -> String {
        return productList[indexPath.row].images?[0] ?? ""
    }
    
    public func getProductName(indexPath: IndexPath) -> String {
        return productList[indexPath.row].name ?? ""
    }
    
    public func getProductPrice(indexPath: IndexPath) -> String {
        return productList[indexPath.row].price?.priceDisplay ?? ""
    }
    
    public func getStrikedProductPrice(indexPath: IndexPath) -> String {
        return productList[indexPath.row].price?.strikeThroughPriceDisplay ?? ""
    }
    
    public func getMinProductPrice(indexPath: IndexPath) -> Int {
        return productList[indexPath.row].price?.minPrice ?? 0
    }
}
