//
//  AccordionView.swift
//  CheckSplitter
//
//  Created by Krzysztof Jarocha (student LM) on 5/3/21.
//  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
//

import SwiftUI
//struct that allows for the collapsing and expanding of the Payer Card so that when a payer card is expanded all of the food items are shown there
struct AccordionView: View {
    //necesary bindinds to Payers and FoodItems
    @Binding var payer: Payer
    @Binding var payers: [Payer]
    @Binding var cart: [FoodItem]
    var body: some View {
        //calls the collapse view
        CollapsibleView(
            //the label for the collapsible view is the payercard for each payer
            label: { PayCard(payer: self.$payer, payers: self.$payers) },
            content: {
                //display all the food items that belong to each payer
                HStack {
                    Text("FoodItems").font(.system(size: 36, weight: .semibold))
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.leading, 40)
                .background(Color.white)
            }
        ).frame(maxWidth: .infinity)}
}

struct AccordionView_Previews: PreviewProvider {
    static var previews: some View {
        AccordionView(payer: Binding.constant(Payer()), payers: Binding.constant([Payer()]), cart: Binding.constant([FoodItem()]))
    }
}
