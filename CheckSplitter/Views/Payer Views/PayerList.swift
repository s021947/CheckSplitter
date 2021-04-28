//
//  PayerList.swift
//  CheckSplitter
//
//  Created by Krzysztof Jarocha (student LM) on 4/19/21.
//  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
//

import SwiftUI

struct PayerList: View {
    //Binding to the array of payers
    @Binding var payers: [Payer]

    var body: some View {
        ZStack{
        //creates gradient background
        LinearGradientView()
        ScrollView(){
        VStack(spacing: 20){
        Text("")
        Text("")
        Spacer()
                ForEach(payers.indices, id: \.self) { i in
                      PayerCard(payer: self.$payers[i], payers: self.$payers)//loops through every index of the contacts array and for every index i create a new card with information from contacts array
                  }
                Spacer()
            //creates a navigationLink to the PayerDetail view where the user can add an additional payer to the array of already existing payers
            NavigationLink(destination: PayerDetail(payers: $payers)) {
                ButtonView(buttonText: "Add New Payer", buttonColor: Color.black)
            }
            //returns user to home screen
            DismissView()
            }
                
        }.background(LinearGradientView()).frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
}


struct PayerList_Previews: PreviewProvider {
    static var previews: some View {
        PayerList(payers: Binding.constant([Payer]()))
    }
}
