//
//  ProductInfoCell.swift
//  EBSInternshipApp
//
//  Created by Rauh Andrei on 26.10.2021.
//

import UIKit

class ProductInfoCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var productImage: IconView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productShortDescriptionLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productPastPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    //MARK: - Constants
    static let identifier = "ProductInfoCell"
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureFonts()
    }
    
    //MARK: - Configure
    func configure(with data: ProductData) {
        productNameLabel.text = data.name
        productShortDescriptionLabel.text = "\(data.size) - \(data.colour)"
        productPriceLabel.text = "$\(data.price),-"
        productPastPriceLabel.text = "$\(data.price),-"
        productDescriptionLabel.text = data.details
        productImage.set(imageURL: data.category.icon)
    }
    
    private func configureFonts() {
        productNameLabel.font = UIFont(name: "OpenSans-Extrabold", size: 20)
        productShortDescriptionLabel.font = UIFont(name: "OpenSans-Regular", size: 12)
        productPriceLabel.font = UIFont(name: "OpenSans-Semibold", size: 16)
        productPastPriceLabel.font = UIFont(name: "OpenSans-Semibold", size: 11)
        productDescriptionLabel.font = UIFont(name: "OpenSans-Regular", size: 12)
    }
}
