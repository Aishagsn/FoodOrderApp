//
//  FoodViewController.swift
//  FoodOrderApp
//
//  Created by Aisha on 07.06.24.
//

import UIKit
import Kingfisher

class FoodViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    
    @IBOutlet weak var foodCollectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var foodList = [Food]()
    var filterFood = [Food]()
    let dataLoader = DataLoader()
    var restaurants: [Restaurant] = []
    var basketItems: [Food] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        searchBar.delegate = self
        foodCollectionView.dataSource = self
        foodCollectionView.delegate = self
        foodCollectionView.register(UINib(nibName: "FoodCell", bundle: nil), forCellWithReuseIdentifier: "FoodCell")
        
        let foodDesign = UICollectionViewFlowLayout()
        foodDesign.sectionInset = UIEdgeInsets(top: 8, left: 3, bottom: 8, right: 3)
        foodDesign.minimumLineSpacing = 20
        foodDesign.minimumInteritemSpacing = 10
        let width = foodCollectionView.frame.size.width
        let cellWidht = (width - 30) / 2
        foodDesign.itemSize = CGSize(width: cellWidht, height: cellWidht*1.1)
        foodCollectionView.collectionViewLayout = foodDesign
        
//        filterFood = restaurants.flatMap { $0.foods }
        filterFood = foodList  // Initially show all foods
               
    }
    func load(){
        guard let path = Bundle.main.path(forResource: "restaurants", ofType: "json") else {
            print("Failed to find restaurants.json file")
            return
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            restaurants = try JSONDecoder().decode([Restaurant].self, from: data)
            filterFood = restaurants.flatMap { $0.foods }
            
            self.foodCollectionView.reloadData()
        } catch {
            print("Error: \(error)")
            
        }
    }
        
        
    
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            return filterFood.count
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath) as! FoodCell
            let food = filterFood[indexPath.row]
                    cell.configure(with: food)
            
            cell.foodNameLabel.text = food.name + " - \(food.price)"
            cell.imageView.image = UIImage(named: food.image)
                   cell.plusButton.tag = indexPath.row
                   cell.plusButton.addTarget(self, action: #selector(addItemToBasket(_:)), for: .touchUpInside)
            cell.addTapped = { [weak self] in
                        guard let self = self else { return }
                        self.showFoodDetail(for: food)
                    }
            
//            let items = restaurants[indexPath.row].foods[indexPath.row]
//            cell.foodNameLabel.text = items.name + "- \(items.price)"
//            
//            cell.imageView.image = UIImage(named: food.image)
//            cell.foodNameLabel.text = food.name
//            cell.foodPriceLabel.text = "\(food.price)"
//            cell.plusButton.tag = indexPath.section * 1000 + indexPath.row
//            cell.plusButton.addTarget(self, action: #selector(addItemToBasket(_:)), for: .touchUpInside)
            
            return cell

        }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let food = filterFood[indexPath.row]
        }
        
        func showFoodDetail(for food: Food) {
            let foodDetailVC = storyboard?.instantiateViewController(withIdentifier: "FoodDetailViewController") as! FoodDetailViewController
            foodDetailVC.food = food
            navigationController?.pushViewController(foodDetailVC, animated: true)
        }
        
    }

    
    extension FoodViewController : UISearchBarDelegate
    {
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
 
            filterFood = searchText.isEmpty ? foodList : foodList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
                foodCollectionView.reloadData()
           }
        
        
//        @objc func addItemToBasket(_ sender: UIButton) {
////            let section = (sender as AnyObject).tag / 1000
////            let row = (sender as AnyObject).tag % 1000
////            let item = restaurants[section].foods[row]
////            BasketManager.shared.addItem(item)
////            print("Added \(item.name) to basket. Total price: \(BasketManager.shared.totalPrice())")
////        }
//            let food = filterFood[sender.tag]
//                   BasketManager.shared.addItem(food)
//                   print("Added \(food.name) to basket. Total price: \(BasketManager.shared.totalPrice())")
//               }
        @objc func addItemToBasket(_ sender: UIButton) {
            let food = filterFood[sender.tag]
                   basketItems.append(food)
                   
                   let storyboard = UIStoryboard(name: "Main", bundle: nil)
                   let tabBarVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
                   
                   if let basketVC = tabBarVC.viewControllers?.first(where: { $0 is BasketViewController }) as? BasketViewController {
                       basketVC.basketItems = basketItems
                   }
                   
                   tabBarVC.selectedIndex = 1 // Basket tab is at index 1
                   navigationController?.pushViewController(tabBarVC, animated: true)
               }
           }

