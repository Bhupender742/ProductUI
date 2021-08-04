//
//  ProductListViewController.swift
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

    private var productViewModel = ProductViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUpTableView()
        styleTableView()
        
        productViewModel.fetchProducts {
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }
        
    }

}

//MARK:- ViewController Extension
extension ViewController {
    
    private func setUpTableView() {
        myTableView.register(ProductCell.self, forCellReuseIdentifier: String(describing: ProductCell.self))
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
        return productViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductCell.self), for: indexPath) as? ProductCell
        
        cell?.configure(cellViewModel: productViewModel.getCellModel(at: indexPath))
        
        return cell!
    }
    
}

