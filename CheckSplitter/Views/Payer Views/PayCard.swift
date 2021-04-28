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
        HStack{
            //creates an image for each of the payers
            Image(payer.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100, alignment: .center)
                .clipped()
            //displays the name of the payer
            VStack(alignment: .leading){
                Text(payer.name).font(.system(size: 30))
                    .foregroundColor(.black)
                    .minimumScaleFactor(0.0001)
                    .lineLimit(1).frame(width: 235, height: 30, alignment: .center)
                //displays the amount of money for each payer formatted to two decimal places
                Text("Due:  \(payer.amount, specifier: "$%.2f")").font(.system(size: 30))
                .minimumScaleFactor(0.0001)
                .lineLimit(1).frame(width: 235, height: 30, alignment: .center)
            }
            
        }.background(Color.white.opacity(0.25)).cornerRadius(20).cornerRadius(20)
            .padding(.horizontal, 10)//customizes backgorund of each PayCard
        }
        }
}

struct PayCard_Previews: PreviewProvider {
    static var previews: some View {
        PayCard(payer: Binding.constant(Payer()), payers: Binding.constant([Payer()]))
    }
}

