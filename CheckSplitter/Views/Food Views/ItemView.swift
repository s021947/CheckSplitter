//
//  ItemView.swift
//  CheckSplitter
//
//  Created by Krzysztof Jarocha (student LM) on 4/19/21.
//  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
//

import SwiftUI
//View that displays all of the food items for a certain payer from the photo of the bill provided from the user
struct ItemView: View {
    //create bindings for the array of food items belonging to a certain payer
    @Binding var cart: [FoodItem]
    
    @State var removedItems: [FoodItem] = []
 
    var body: some View {
                VStack(alignment: .leading){
                ForEach(cart.indices, id: \.self) { i in
                    FoodDisplay(item: self.$cart[i])//loops through every index of the food items array and for every index i create a new FoodDisplay with information from fooditems array
                }
                }.frame(height: 100)
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(cart: Binding.constant([FoodItem(), FoodItem()]))
    }
}
