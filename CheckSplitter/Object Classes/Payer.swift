//
//  Payer.swift
//  CheckSplitter
//
//  Created by Krzysztof Jarocha (student LM) on 4/19/21.
//  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
//

import Foundation
//cretaes a Payer class where an payer object is created and initialized
class Payer: ObservableObject,Identifiable, Equatable, Hashable{
    //checks if any two items inside of the payer class are equal
    static func == (lhs: Payer, rhs: Payer) -> Bool {
        return (lhs.name == rhs.name && lhs.items == rhs.items)
    }
    //creates a hash value for the payer
    var hashValue: Int {
        return self.id
    }
//all editable properties of a payer object
@Published var name : String
@Published var amount: Double
@Published var index: Int
@Published var items: [FoodItem]
//id of each payer
var id: Int

//initialize a Payer
    init(name : String = "Payer", amount : Double = 0.0, index: Int = 0, id : Int = 0, items: [FoodItem] = [FoodItem()]){
    self.name = name
    self.amount = amount
    self.index = index
    self.id = id
    self.items = items
    
    //give default amount to pay for the payers based on the total cost of the intial food items in their cart
    self.updateAmount()
}
    //function to update the amount of money each payer has to pay, used when assigning different parts of the bill to each payer
    func updateAmount(){
        self.amount = 0
        for item in self.items{
            //for every item that belongs to each payer, add the price fo each food item to thats payers amount
            self.amount += item.price
        }
    }
    //add appropriate tax amounts to the amount the payer is paying for their food items
    func applyTax(){
        self.amount += self.amount*0.06//sets the taxed portion of the users amount and adds it to the amount of money due
    }
    //add appropriate tip amounts to the amount the payer is paying for their food items and lets payer choose how much tip they would like to give
    func addTip(percentTip: Double){
        self.amount += (percentTip/100)*self.amount//sets the tipped portion of the users amount and adds it to the amount of money due
    }
    
}
