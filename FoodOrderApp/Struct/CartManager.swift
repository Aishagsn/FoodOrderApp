//
//  CartManager.swift
//  FoodOrderApp
//
//  Created by Aisha on 24.06.24.
//

import Foundation

class CartManager: ObservableObject {
    @Published var items: [Food] = []
    
    func addToCart(_ item: Food) {
        items.append(item)
    }

    func totalPrice() -> Double {
        return items.reduce(0) { $0 + $1.price }
    }
}

