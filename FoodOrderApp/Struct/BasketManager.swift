//
//  BasketManager.swift
//  FoodOrderApp
//
//  Created by Aisha on 25.06.24.
//

import Foundation

class BasketManager {
    static let shared = BasketManager()
    private init() {}
    
    private var items: [(food: Food, quantity: Int)] = []
    
    func addItem(_ food: Food, quantity: Int = 1) {
        if let index = items.firstIndex(where: { $0.food.name == food.name }) {
            items[index].quantity += quantity
        } else {
            items.append((food: food, quantity: quantity))
        }
    }
    
    func totalPrice() -> Double {
        return items.reduce(0) { $0 + ($1.food.price * Double($1.quantity)) }
    }
}
