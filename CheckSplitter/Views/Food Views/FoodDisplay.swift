//
//  FoodDisplay.swift
//  CheckSplitter
//
//  Created by Krzysztof Jarocha (student LM) on 4/21/21.
//  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
//

import SwiftUI

struct FoodDisplay: View {
    //Binding to existing FoodItem, selection String, and current Item Price
    @Binding var item : FoodItem
    
    
    var body: some View {
     
  
        HStack{
            //displays the name of the FoodItem
                Text(item.name).font(.system(size: 40))
                    .foregroundColor(.black)
                    .minimumScaleFactor(0.0001)
                    .lineLimit(1)
                //displays the price of the FoodItem with the double being rounded to two decimal places
                Text("\(item.price, specifier: "$%.2f")").font(.system(size: 40))
                .minimumScaleFactor(0.0001)
                .lineLimit(1)
        }.background(Color.white.opacity(0.25)).cornerRadius(20).cornerRadius(20)
            .padding(.horizontal, 15).frame(width: 450, height: 100)//customizes backgorund of each PayerCard
        
    
}
}

struct FoodDisplay_Previews: PreviewProvider {
    static var previews: some View {
        FoodDisplay(item: Binding.constant(FoodItem()))
    }
}
