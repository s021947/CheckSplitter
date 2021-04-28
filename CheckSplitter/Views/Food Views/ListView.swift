//
//  ListView.swift
//  CheckSplitter
//
//  Created by Krzysztof Jarocha (student LM) on 4/26/21.
//  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
//

import SwiftUI
//creates a list of all the payers and lets the users assign FoodItems to Payers
struct ListView: View {
    //necessary bindings
    @Binding var payers: [Payer]
    @Binding var price: Double
    var body: some View {
        ZStack{
        LinearGradientView()
        ScrollView(){
            VStack(spacing: 20){
                ForEach(payers.indices, id: \.self) { i in
                    Button(action: {
                        //adds the value of the selected Food Item to the amount the selected payer is owed
                        self.payers[i].updateAmount(amount: self.price)
                    }){
                    //displays all the names of the current payers, lets the user select which payer they want
                        Text(self.payers[i].getName()).font(.system(size: 36, weight: .semibold)).foregroundColor(Color.white)
                    }
                }
            Spacer()
            //returns user to home screen
            DismissView(text: "Assign Payer")
            }
        }.background(LinearGradientView()).frame(maxWidth: .infinity, maxHeight: .infinity)//creates a infinite width frame to allow for as many users to be viewed as possible
        }
        }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(payers: Binding.constant([Payer]()), price: Binding.constant(Double()))
    }
}
