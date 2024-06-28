//
//  HomeViewController.swift
//  FoodOrderApp
//
//  Created by Aisha on 01.06.24.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var restaurantList = [Restaurant]()
    var filterRestaurant = [Restaurant]()
    var restaurants: [Restaurant] = []
    let dataLoader = DataLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: "RestaurantCell", bundle: nil), forCellWithReuseIdentifier: "RestaurantCell")
        load()
    }

    


    func load() {
            if let path = Bundle.main.path(forResource: "restaurants", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path))
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode([String: [Restaurant]].self, from: data)
                    if let restaurants = jsonData["restaurants"] {
                        self.restaurants = restaurants
                    }
                } catch {
                    print("Error: \(error)")
                }
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCell", for: indexPath) as! RestaurantCell
                let restaurant = restaurants[indexPath.row]
        
        print("Restaurant is \(restaurants)")
                cell.imageView.image = UIImage(named: restaurant.image)
                cell.nameLabel.text = restaurant.name
                
                return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let restaurant = restaurants[indexPath.row]
        let foodCollectionViewController =  storyboard?.instantiateViewController(withIdentifier: "FoodViewController") as! FoodViewController
        foodCollectionViewController.filterFood = restaurant.foods
        navigationController?.show(foodCollectionViewController, sender: nil)
           }
    }

extension HomeViewController : UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterRestaurant = self.restaurantList.filter { f in
            if f.name.lowercased().contains(searchText.lowercased()) {
                return true
            }
            if searchText.isEmpty {
                return true
            }
            return false
        }
        self.collection.reloadData()
    }
}

