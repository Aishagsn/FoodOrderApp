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

        var items: [Food] = []

        func addItem(_ item: Food) {
            items.append(item)
        }

        func totalPrice() -> Double {
            return items.reduce(0) { $0 + $1.price }
        }
    }


