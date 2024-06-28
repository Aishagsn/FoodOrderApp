//
//  BasketCell.swift
//  FoodOrderApp
//
//  Created by Aisha on 24.06.24.
//

import UIKit

class BasketCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func configure(with food: Food) {
        imageView.kf.setImage(with: URL(string: food.image))
        nameLabel.text = food.name
        priceLabel.text = "$\(food.price)"
    }
}

