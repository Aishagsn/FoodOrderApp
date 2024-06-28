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
    
    var foodList = [Foods]()
    var filterFood = [Food]()
    let dataLoader = DataLoader()
    var restaurants: [Restaurant] = []
    
    
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
        
        filterFood = restaurants.flatMap { $0.foods } // Initially show all foods
               
    }
    func load(){
        guard let path = Bundle.main.path(forResource: "restaurants", ofType: "json") else {
            print("Failed to find restaurants.json file")
            return
        }
            do {
                
//                let data = try Data(contentsOf: URL(fileURLWithPath: path))
//                let decoder = JSONDecoder()
//                let jsonData = try decoder.decode([String: [Food]].self, from: data)
//                restaurants = try JSONDecoder().decode([Restaurant].self, from: data)
//                if let foodList = jsonData["restaurants"] {
//                    self.filterFood = foodList
//                }\
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                          restaurants = try JSONDecoder().decode([Restaurant].self, from: data)
                      
            } catch {
                print("Error: \(error)")
                
            }
        }
        
    
        
//        func numberOfSections(in collectionView: UICollectionView) -> Int {
//
//            return filterFood.count
//        }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//            let itemCount = restaurants[section].foods.count
//                    print("Number of items in section \(section): \(itemCount)")
//                    return itemCount
            return filterFood.count
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath) as! FoodCell
            let food = filterFood[indexPath.row]
                    cell.configure(with: food)
            
            let items = restaurants[indexPath.row].foods[indexPath.row]
            cell.foodNameLabel.text = items.name + "- \(items.price)"
            
            cell.imageView.image = UIImage(named: food.image)
            cell.foodNameLabel.text = food.name
            cell.foodPriceLabel.text = "\(food.price)"
            cell.plusButton.tag = indexPath.section * 1000 + indexPath.row
            cell.plusButton.addTarget(self, action: #selector(addItemToBasket(_:)), for: .touchUpInside)
            
            return cell

        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let filteredFood = filterFood[indexPath.row]
            
        }
        
    }
    
    extension FoodViewController : UISearchBarDelegate
    {
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
               // Perform filtering based on search text
               if searchText.isEmpty {
                   filterFood = restaurants.flatMap { $0.foods }
               } else {
                   filterFood = restaurants.flatMap { $0.foods.filter { $0.name.lowercased().contains(searchText.lowercased()) } }
               }
               foodCollectionView.reloadData()
           }
        
        
        @objc func addItemToBasket(_ sender: UIButton) {
//            let section = (sender as AnyObject).tag / 1000
//            let row = (sender as AnyObject).tag % 1000
//            let item = restaurants[section].foods[row]
//            BasketManager.shared.addItem(item)
//            print("Added \(item.name) to basket. Total price: \(BasketManager.shared.totalPrice())")
//        }
            let food = filterFood[sender.tag]
                   BasketManager.shared.addItem(food)
                   print("Added \(food.name) to basket. Total price: \(BasketManager.shared.totalPrice())")
               }
    }
    

