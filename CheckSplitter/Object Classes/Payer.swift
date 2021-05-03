//
//  Payer.swift
//  CheckSplitter
//
//  Created by Krzysztof Jarocha (student LM) on 4/19/21.
//  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
//

import Foundation
//cretaes a Payer class where an payer object is created and initialized
class Payer: ObservableObject{

//all properties of a payer object
@Published var name : String
@Published var amount: Double
@Published var index: Int

//initialize a Payer
    init(name : String = "Payer", amount : Double = 0.0, index: Int = 0){
    self.name = name
    self.amount = amount
    self.index = index
}
    //function to update the amount of money each payer has to pay, used when assigning different parts of the bill to each payer
    func updateAmount(amount: Double){
        self.amount += amount
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
