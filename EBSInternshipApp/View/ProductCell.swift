//
//  ProductCell.swift
//  EBSInternshipApp
//
//  Created by Rauh Andrei on 18.10.2021.
//

import UIKit

protocol ProductCellDelegate: AnyObject {
    func cellDidTappedLikeButton(_ cell: ProductCell)
    func cellDidTappedCartButton(_ cell: ProductCell)
}

class ProductCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet private var productNameLabel: UILabel!
    @IBOutlet private var productDescriptionLabel: UILabel!
    @IBOutlet private var productActualPriceLabel: UILabel!
    @IBOutlet private var productPastPriceLabel: UILabel!
    @IBOutlet private var productImage: IconView!
    
    weak var delegate: ProductCellDelegate?
    static let identifier = "ProductCell"
    
    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureFonts()
    }
    
    //MARK: - Actions
    @IBAction func addToFavoriteTapped(_ sender: UIButton) {
        delegate?.cellDidTappedLikeButton(self)
    }
    
    @IBAction func addToCartTapped(_ sender: UIButton) {
        delegate?.cellDidTappedCartButton(self)
    }
    
    //MARK: - Configure
    func configure(with data: ProductData) {
        productNameLabel.text = data.name
        productDescriptionLabel.text = "\(data.size) - \(data.colour)"
        productActualPriceLabel.text = "$ \(data.price)"
        productPastPriceLabel.text = "$ \(data.price)"
        productImage.set(imageURL: data.category.icon)
    }
    
    private func configureFonts() {
        productNameLabel.font = UIFont(name: "OpenSans-Extrabold", size: 18)
        productDescriptionLabel.font = UIFont(name: "OpenSans-Regular", size: 12)
        productActualPriceLabel.font = UIFont(name: "OpenSans-Semibold", size: 16)
        productPastPriceLabel.font = UIFont(name: "OpenSans-Semibold", size: 11)
    }
}

