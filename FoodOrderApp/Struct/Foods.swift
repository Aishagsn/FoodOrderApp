//
//  Foods.swift
//  FoodOrderApp
//
//  Created by Aisha on 07.06.24.
//

import Foundation

class Foods : Codable
{
    var food_id : String?
    var food_name : String?
    var food_price : String?
    var food_image: String?
    
    init(){
        
    }
    
    init(food_id : String, food_name : String, food_price : String, food_image : String )
    {
        self.food_id = food_id
        self.food_name = food_name
        self.food_price = food_price
        self.food_image = food_image
    }
}
