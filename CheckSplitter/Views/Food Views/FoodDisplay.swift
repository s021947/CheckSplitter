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
    @Binding var selection : String?
    @Binding var price: Double
    
    
    
    var body: some View {
     
  
        HStack{
            //creates a custom clipped image for each of the Food Items
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100, alignment: .top)
                .clipped()
            //displays the name of the FoodItem
            VStack(alignment: .leading){
                Text(item.name).font(.system(size: 40))
                    .foregroundColor(.black)
                    .minimumScaleFactor(0.0001)
                    .lineLimit(1)
                //displays the price of the FoodItem with the double being rounded to two decimal places
                Text("\(item.price, specifier: "$%.2f")").font(.system(size: 40))
                .minimumScaleFactor(0.0001)
                .lineLimit(1)
            }
            
            //Button that sets the selection string to a certain value so the user can open up the selectionView for the appriopriate food object
            //also sets the price to the price
            Button(action: {
                self.selection = "ListView"
                self.price = self.item.price
            }){
                Text("Assign").foregroundColor(Color.blue).font(.system(size: 30))
                
            }
                
            
        }.background(Color.white.opacity(0.25)).cornerRadius(20).cornerRadius(20)
            .padding(.horizontal, 15).frame(width: 450, height: 100)//customizes backgorund of each PayerCard
        
    
}
}

struct FoodDisplay_Previews: PreviewProvider {
    static var previews: some View {
        FoodDisplay(item: Binding.constant(FoodItem()), selection: Binding.constant(String()), price: Binding.constant(Double()))
    }
}
