//
//  ViewController.swift
//  ProductUI
//
//  Created by Bhupender Rawat on 22/07/21.
//

import UIKit

class ViewController: UIViewController {
    
    private var myTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    var productList = [Product]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://www.blibli.com/backend/search/products?searchTerm=Samsung&start=0&itemPerPage=10"
       
        setUpTableView()
        styleTableView()
        
        NetworkManager<APIResponse>().fetchData(from: urlString) { (result) in
            self.productList = (result.data?.products)!
            self.myTableView.reloadData()
        }
        
    }


}

//MARK:- ViewController Extension
extension ViewController {
    private func setUpTableView() {
        myTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: String(describing: CustomTableViewCell.self))
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    private func styleTableView() {
        self.view.addSubview(myTableView)
        NSLayoutConstraint.activate([
                                        myTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
                                        myTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                                        myTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                        myTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}

//MARK:- TableViewDelegate Methods
extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

//MARK:- TableViewDataSource Methods
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CustomTableViewCell.self), for: indexPath) as? CustomTableViewCell
        
        let imageURL = productList[indexPath.row].images?[0]
        let productName = productList[indexPath.row].name ?? ""
        let productPrice = productList[indexPath.row].price?.priceDisplay
        let strikedProductPrice = productList[indexPath.row].price?.strikeThroughPriceDisplay ?? ""
        let minProductPrice = productList[indexPath.row].price?.minPrice ?? 0
        
        cell?.configure(imageURL: imageURL, name: productName, price: productPrice!, strikedPrice: strikedProductPrice, minPrice: minProductPrice)
        
        return cell!
    }
    
    
}

