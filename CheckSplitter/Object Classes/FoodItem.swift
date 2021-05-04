//
//  FoodItem.swift
//  CheckSplitter
//
//  Created by Krzysztof Jarocha (student LM) on 4/20/21.
//  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
//

import Foundation
//creates a struct to store each food item that will come from the image scan of the bill
struct FoodItem: Equatable{//makes struct equatable

//all properties of a food object
var name : String
var price: Double

    
    //initialize a default FoodItem object 
    init(name: String = "Chicken", price: Double = 29.5){
        self.name = name
        self.price = price
    }


}
