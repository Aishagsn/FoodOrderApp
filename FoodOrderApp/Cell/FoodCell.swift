//
//  FoodCell.swift
//  FoodOrderApp
//
//  Created by Aisha on 24.06.24.
//

import UIKit

class FoodCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    
    var addTapped: (() -> Void)?
    
    func configure(with food: Food) {
           foodNameLabel.text = food.name
        foodPriceLabel.text = "\(food.price)"
           if let image = UIImage(named: food.image) {
               imageView.image = image
           }
    
    }
    @IBAction func addTappedButton(_ sender: UIButton) {
           addTapped?()
       }
    
}
