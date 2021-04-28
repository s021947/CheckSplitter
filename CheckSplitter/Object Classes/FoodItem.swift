//
//  FoodItem.swift
//  CheckSplitter
//
//  Created by Krzysztof Jarocha (student LM) on 4/20/21.
//  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
//

import Foundation
//creates a struct to store each food item that will come from the image bill
struct FoodItem{

//all properties of a food object
var name : String
var price: Double
var image: String
    
    //initialize a FoodItem object 
    init(name: String = "Chicken", price: Double = 29.5, image: String = "logo"){
        self.name = name
        self.price = price
        self.image = image
    }


}
