//
//  CustomTableViewCell.swift
//  ProductUI
//
//  Created by Bhupender Rawat on 22/07/21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var imagePreview: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var strikedPriceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var minPriceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var bookButton: UIButton = {
       let button = UIButton()
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
    
    private func styleView() {
        contentView.addSubview(containerView)
        containerView.fillSuperview()
        
        containerView.addSubview(imagePreview)
        imagePreview.anchor(nil, left: containerView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 8, bottomConstant: 8, rightConstant: 0, widthConstant: 100, heightConstant: 100)
        imagePreview.anchorCenterYToSuperview(constant: 0)
        
        containerView.addSubview(nameLabel)
        nameLabel.anchor(containerView.topAnchor, left: imagePreview.rightAnchor, bottom: nil, right: containerView.rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        
        containerView.addSubview(priceLabel)
        priceLabel.anchor(nameLabel.bottomAnchor, left: imagePreview.rightAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 120, heightConstant: 0)
        priceLabel.numberOfLines = 0
        priceLabel.font = UIFont.systemFont(ofSize: 16)
        
        containerView.addSubview(strikedPriceLabel)
        strikedPriceLabel.anchor(priceLabel.bottomAnchor, left: imagePreview.rightAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 120, heightConstant: 0)
        strikedPriceLabel.font = UIFont.systemFont(ofSize: 14)
        
        containerView.addSubview(minPriceLabel)
        minPriceLabel.anchor(strikedPriceLabel.bottomAnchor, left: imagePreview.rightAnchor, bottom: containerView.bottomAnchor, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 0, widthConstant: 120, heightConstant: 0)
        minPriceLabel.font = UIFont.systemFont(ofSize: 12)
        
        containerView.addSubview(bookButton)
        bookButton.anchor(nil, left: nil, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 16, rightConstant: 16, widthConstant: 72, heightConstant: 32)
        bookButton.setTitle("Book", for: .normal)
        bookButton.backgroundColor = .blue
        
    }
    
    func configure(imageURL: String?, name: String, price: String, strikedPrice: String, minPrice: Int) {
        imagePreview.downloaded(from: imageURL)
        nameLabel.text = name
        priceLabel.text = price
        strikedPriceLabel.attributedText = strikedPrice.strikeThrough()
        minPriceLabel.text = "minPrice: \(minPrice)"
    }
}

//MARK:- UIImageView Extension
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
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
    func downloaded(from link: String?, contentMode mode: ContentMode = .scaleAspectFit) {
        if let link = link {
            guard let url = URL(string: link) else { return }
            downloaded(from: url, contentMode: mode)
        }
    }
}

//MARK:- String Extension
extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
               value: NSUnderlineStyle.single.rawValue,
                   range:NSMakeRange(0,attributeString.length))
        return attributeString
    }
}
