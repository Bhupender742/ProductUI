//
//  ProductViewModel.swift
//  ProductUI
//
//  Created by Bhupender Rawat on 02/08/21.
//

import UIKit

class ProductViewModel: NSObject {
    
    private let urlString = "https://www.blibli.com/backend/search/products?searchTerm=Samsung&start=0&itemPerPage=10"
    
    private var productList = [Product]()
    private var productCellViewModels = [ProductCellViewModel]()
    
    public func fetchProducts(completion: @escaping () -> Void) {
        NetworkManager<APIResponse>().fetchData(from: urlString) { (result) in
                    self.productList = result.data?.products ?? []
                    completion()
        }
    }
    
}

extension ProductViewModel {
    
    public func getCellModel(at indexPath: IndexPath) -> ProductCellViewModel {
        return productCellViewModels[indexPath.row]
    }
    
    public func numberOfRowsInSection() -> Int {
        productCellViewModels = productList.map{ ProductCellViewModel(with: $0) }
        return productList.count
    }
    
}
