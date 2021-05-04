//
//  FoodDisplay.swift
//  CheckSplitter
//
//  Created by Krzysztof Jarocha (student LM) on 4/21/21.
//  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
//

import SwiftUI
//creates a struct that displays the properties of an individual Food Item
struct FoodDisplay: View {
    @State var position = CGPoint(x: 140, y: 0)
    
    //Binding to existing FoodItem
    @Binding var item : FoodItem
    
    
    var body: some View {
        //HStack for both of the state properties of a Food Item
        HStack{
            //displays the name of the FoodItem
                Text(item.name).font(.custom("Helvetica Neue", size: 20))
                    .foregroundColor(.gray)
                    .minimumScaleFactor(0.0001)
                    .lineLimit(1).padding(.trailing, 100)//spaces out the text boxes appriopriately
            //displays the price of the FoodItem with the double being rounded to two decimal places
                Text("\(item.price, specifier: "$%.2f")").font(.custom("Helvetica Neue", size: 20))
                .minimumScaleFactor(0.0001)
                    .lineLimit(1).foregroundColor(Color(red: 237/240, green: 164/240, blue: 172/240))
        }.position(x: self.position.x, y: self.position.y)
        .gesture(
            DragGesture()
                .onChanged({ value in
                    self.position.y = value.location.y
                })).frame(width: 400, height: 50)
        
    
}
}

struct FoodDisplay_Previews: PreviewProvider {
    static var previews: some View {
        FoodDisplay(item: Binding.constant(FoodItem()))
    }
}
