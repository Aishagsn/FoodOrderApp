//
//  FoodDetailViewController.swift
//  FoodOrderApp
//
//  Created by Aisha on 07.06.24.
//

import UIKit

class FoodDetailViewController: UIViewController {
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    
    var food: Food?
    var quantity: Int = 1
    var price: Double = 0.0
    
    override func viewDidLoad() {
            super.viewDidLoad()
            updateUI()
        }

        func updateUI() {
            guard let food = food else { return }
            foodImageView.image = UIImage(named: food.image)
            foodNameLabel.text = food.name
            foodPriceLabel.text = String(format: "$%.2f", food.price)
            quantityLabel.text = "\(quantity)"
            totalLabel.text = String(format: "Tutar: $%.2f", food.price * Double(quantity))
        }

        @IBAction func incrementQuantity(_ sender: UIButton) {
            quantity += 1
            updateUI()
        }
    
        @IBAction func decrementQuantity(_ sender: UIButton) {
            if quantity > 1 {
                quantity -= 1
                updateUI()
            }
        }

        @IBAction func addToBasket(_ sender: UIButton) {
            guard let food = food else { return }
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.basketItems.append(food)
            
            // Tab bar'daki BasketViewController'a geçiş yapma
            if let tabBarController = self.tabBarController {
                tabBarController.selectedIndex = 1
            }
        }
    }
