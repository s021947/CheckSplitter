//
//  PayView.swift
//  CheckSplitter
//
//  Created by Krzysztof Jarocha (student LM) on 4/27/21.
//  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
//

import SwiftUI

struct PayView: View {
    //Binding to the array of payers
    @Binding var payers: [Payer]
    //Boolean that allows for the addition of tax and tip to each payer
    @State var addTaxTip: Bool = false
    //var that stores how much tip the payers want to give
    @State var tip: String = ""
    var body: some View {
        ZStack{
            LinearGradientView()
            ScrollView(){
                VStack(spacing: 20){
                Text("")
                Text("")
                Spacer()
                ForEach(payers.indices, id: \.self) { i in
                    PayCard(payer: self.$payers[i], payers: self.$payers)//loops through every index of the payers array and for every index i create a paycard with information from payers array
                }
            Spacer()
            if !self.addTaxTip{
                //input form for the pertage tip that the payers want to give
                    TextField("Enter Tip%: ", text: self.$tip).font(.system(size: 36))
                    
            //button for adding tax to each payer, once the button has been clicked it disappears to avoid adding tax multiple times
            Button(action: {
                self.addTaxTip = true
                if self.addTaxTip{
                    //convert user input for tip percentage into a double
                    let tipDouble = Double(self.tip)
                    
                    for payer in self.payers{
                    //add appriopriate tax amount to each payer
                    payer.applyTax()
                    //add appriopriate tip amount to each payer
                    payer.addTip(percentTip: tipDouble!)
                               }
                               }
            }){
                ButtonView(buttonText: "Add Tax&Tip", buttonColor: Color.green)
                }
                }

            //returns user to home screen
            DismissView()
                
                    }.background(LinearGradientView()).frame(maxWidth: .infinity, maxHeight: .infinity)           //creates custom background for the scroll view

            }
            }
    }
}

struct PayView_Previews: PreviewProvider {
    static var previews: some View {
        PayView(payers: Binding.constant([Payer()]))
    }
}
