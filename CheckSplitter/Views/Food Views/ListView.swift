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
        
        ScrollView(){
            ZStack{
            //creates background for the edges of the view
            LinearGradientView()

            
            VStack(spacing: 20){
                //displays all the names of the current payers, lets the user select which payer they want to pay for the specified food item
                ForEach(payers.indices, id: \.self) { i in
                    Button(action: {
                        //toggle the payer to selected if the user clicks on them
                        self.payers[i].select()
                    }){
                    //if a user is selected give the text an indicator backgorund that the payer was indeed selected
                        if !self.payers[i].selected{
                        Text(self.payers[i].getName()).font(.system(size: 36, weight: .semibold)).foregroundColor(Color.black)
                        }
                        else{
                            Text(self.payers[i].getName()).font(.system(size: 36, weight: .semibold)).foregroundColor(Color.white)
                        }
                    }
                }
            Spacer()
                Button(action: {
                    for payer in self.payers{
                        if payer.selected{//if a payer was selected
                            //adds the value of the selected Food Item to the amount the selected payer is owed
                            payer.updateAmount(amount: self.price)
                        }
                    }
                }){
                    ButtonView(buttonText: "Assign Payers")
                }
            //returns user to home screen
            DismissView(text: "Go back")

            }
            }.offset(y: -5)
        
        }.background(LinearGradientView()).frame(maxWidth: .infinity, maxHeight: .infinity)//creates a infinite width frame to allow for as many users to be viewed as possible
       
}
}
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(payers: Binding.constant([Payer]()), price: Binding.constant(Double()))
    }
}
