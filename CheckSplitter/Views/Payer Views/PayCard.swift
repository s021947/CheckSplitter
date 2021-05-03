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
       Rectangle()
         .fill(Color.gray)
         .frame(width: UIScreen.main.bounds.width, height: 122)
         
         Rectangle()
         .fill(Color.white)
         .frame(width: UIScreen.main.bounds.width, height: 120)
         
            VStack{
             Button(action: {
                self.payers.remove(at: self.payer.index)
             }) {
                 Image(systemName: "minus").resizable().frame(width: 15, height: 3, alignment: .top).padding(.top,15).padding(.leading,350)
             }.buttonStyle(PlainButtonStyle()).foregroundColor(Color(red: 255/255, green: 178/240, blue: 134/255))
         HStack{
             
            TextField("Payer Name", text: $payer.name).font(.custom("Helvetica Neue", size: 30)).alignmentGuide(.leading) { d in d[.leading] }.foregroundColor(Color.gray).padding(.leading, 30)
             
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

