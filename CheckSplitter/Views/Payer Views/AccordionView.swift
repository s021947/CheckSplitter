//
//  AccordionView.swift
//  CheckSplitter
//
//  Created by Krzysztof Jarocha (student LM) on 5/3/21.
//  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
//

import SwiftUI
//struct that allows for the collapsing and expanding of the Payer Card so that when a payer card is expanded all of the food items that belong to that specifc payer are there
struct AccordionView: View {
    //necesary bindinds to Payer array and an individual payer
    @Binding var payer: Payer
    @Binding var payers: [Payer]
    
    //States necesary for Accordion features of Payer Cards
    @State private var selection: Set<Payer> = []
    @State private var editMode = EditMode.inactive
    var body: some View {
        //calls the collapse view
        CollapsibleView(
            //the label for the collapsible view is the payercard for each payer
            label: { PayerCard(payer: self.$payer, payers: self.$payers) },
            content: {
                //display all the food items that belong to each payer
                HStack {
                    ItemView(cart: self.$payer.items)
                }
                .frame(maxWidth: .infinity)
                .padding(.leading, 40)
                .background(Color.white)//gives padding to all of the Food Items that belong to each payer
        }
        ).frame(maxWidth: .infinity)
    }
}

struct AccordionView_Previews: PreviewProvider {
    static var previews: some View {
        AccordionView(payer: Binding.constant(Payer()), payers: Binding.constant([Payer()]))
    }
}
