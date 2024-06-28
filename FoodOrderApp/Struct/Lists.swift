//
//  Lists.swift
//  FoodOrderApp
//
//  Created by Aisha on 09.06.24.
//

import Foundation

class DataLoader {
    var restaurants: [Restaurant] = []
    
    init() {
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
}

