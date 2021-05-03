//
//  PayCard.swift
//  CheckSplitter
//
//  Created by Krzysztof Jarocha (student LM) on 4/27/21.
//  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
//

//

import SwiftUI

struct PayCard: View {
    //binding to the payer and array of payers
    @Binding var payer: Payer
    @Binding var payers: [Payer]
    var body: some View {
        ZStack{
       //top divider line for each PayCard
        Rectangle()
         .fill(Color.gray)
         .frame(width: UIScreen.main.bounds.width, height: 122)
         
         Rectangle()
         .fill(Color.white)
         .frame(width: UIScreen.main.bounds.width, height: 120)
            
            VStack{
            //button tht when pressed removes the selected payer from the array of payers
            Button(action: {
                //remove payer at chosen index
                self.payers.remove(at: self.payer.index)
             }) {
                //display custom color minus sign as the label for the button
                Image(systemName: "minus").resizable().frame(width: 20, height: 4.5, alignment: .top).padding(.top,15).padding(.leading,335)
             }.buttonStyle(PlainButtonStyle()).foregroundColor(Color(red: 255/255, green: 178/240, blue: 134/255))
         
        HStack{
            //text field that displays the custom payer name for each payer
            TextField("Payer Name", text: $payer.name).font(.custom("Helvetica Neue", size: 30)).alignmentGuide(.leading) { d in d[.leading] }.foregroundColor(Color.gray).padding(.leading, 30)
            //shows the amount that each payer is due in custom color
            Text("$ \(payer.amount, specifier: "%.2f")").font(.custom("Helvetica Neue Bold", size: 30)).alignmentGuide(.leading) { d in d[.leading] }.padding(.trailing, 50).foregroundColor(Color(red: 237/240, green: 164/240, blue: 172/240)).padding(.bottom,25)
         }
        }
        }
}
}

struct PayCard_Previews: PreviewProvider {
    static var previews: some View {
        PayCard(payer: Binding.constant(Payer()), payers: Binding.constant([Payer()]))
    }
}

