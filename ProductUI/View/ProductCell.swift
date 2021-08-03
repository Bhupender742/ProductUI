//
//  ProductCell.swift
//  ProductUI
//
//  Created by Bhupender Rawat on 22/07/21.
//

import UIKit

class ProductCell: UITableViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var priceContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imagePreview: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var strikedPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var minPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bookButton: UIButton = {
       let button = UIButton()
       button.translatesAutoresizingMaskIntoConstraints = false
       return button
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        styleView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProductCell {
    
    private func styleView() {
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
                                        containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
                                        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                                        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        containerView.addSubview(imagePreview)
        NSLayoutConstraint.activate([
                                        imagePreview.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
                                        imagePreview.widthAnchor.constraint(equalToConstant: 100),
                                        imagePreview.heightAnchor.constraint(equalToConstant: 100),
                                        imagePreview.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        containerView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
                                        nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
                                        nameLabel.leadingAnchor.constraint(equalTo: imagePreview.trailingAnchor, constant: 8),
                                        nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        ])
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        
        containerView.addSubview(priceContainerView)
        NSLayoutConstraint.activate([
                                        priceContainerView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
                                        priceContainerView.leadingAnchor.constraint(equalTo: imagePreview.trailingAnchor, constant: 8),
                                        priceContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
                                        priceContainerView.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        priceContainerView.addSubview(priceLabel)
        NSLayoutConstraint.activate([
                                        priceLabel.topAnchor.constraint(equalTo: priceContainerView.topAnchor),
                                        priceLabel.leadingAnchor.constraint(equalTo: priceContainerView.leadingAnchor)
        ])
        priceLabel.numberOfLines = 0
        priceLabel.font = UIFont.systemFont(ofSize: 16)
        
        priceContainerView.addSubview(strikedPriceLabel)
        NSLayoutConstraint.activate([
                                        strikedPriceLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
                                        strikedPriceLabel.leadingAnchor.constraint(equalTo: priceContainerView.leadingAnchor)
        ])
        strikedPriceLabel.font = UIFont.systemFont(ofSize: 14)
        
        priceContainerView.addSubview(minPriceLabel)
        NSLayoutConstraint.activate([
                                        minPriceLabel.topAnchor.constraint(equalTo: strikedPriceLabel.bottomAnchor, constant: 8),
                                        minPriceLabel.leadingAnchor.constraint(equalTo: priceContainerView.leadingAnchor),
                                        minPriceLabel.bottomAnchor.constraint(equalTo: priceContainerView.bottomAnchor)
        ])
        minPriceLabel.font = UIFont.systemFont(ofSize: 12)
        
        containerView.addSubview(bookButton)
        NSLayoutConstraint.activate([
                                        bookButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
                                        bookButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
                                        bookButton.widthAnchor.constraint(equalToConstant: 70),
                                        bookButton.heightAnchor.constraint(equalToConstant: 32)
        ])
        bookButton.setTitle("Book", for: .normal)
        bookButton.backgroundColor = .blue
        
    }
    
    public func configure(imageURL: String?, name: String, price: String, strikedPrice: String, minPrice: Int) {
        imagePreview.downloaded(from: imageURL)
        nameLabel.text = name
        priceLabel.text = price
        strikedPriceLabel.attributedText = strikedPrice.strikeThrough()
        minPriceLabel.text = "minPrice: \(minPrice)"
    }
    
}

//MARK:- UIImageView Extension
extension UIImageView {
    
    public func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    public func downloaded(from link: String?, contentMode mode: ContentMode = .scaleAspectFit) {
        if let link = link {
            guard let url = URL(string: link) else { return }
            downloaded(from: url, contentMode: mode)
        }
    }
    
}

//MARK:- String Extension
extension String {
    
    public func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
               value: NSUnderlineStyle.single.rawValue,
                   range:NSMakeRange(0,attributeString.length))
        return attributeString
    }
    
}
