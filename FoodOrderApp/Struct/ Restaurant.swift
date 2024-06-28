//
//   Restaurant.swift
//  FoodOrderApp
//
//  Created by Aisha on 09.06.24.
//

import Foundation
struct Food: Codable {
    let image: String
    let name: String
    let price: Double
}

struct Restaurant: Codable {
    let image: String
    let name: String
    let foods: [Food]
}

