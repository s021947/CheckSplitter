////
////  ItemDisplay.swift
////  CheckSplitter
////
////  Created by Krzysztof Jarocha (student LM) on 5/4/21.
////  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
////
//
//import SwiftUI
//
//struct ItemDisplay: View {
//    @ObservedObject var display: Item
//
//    var body: some View {
//                VStack(alignment: .leading){
//                HStack{
//                if (display.payer) {
//                    TextField("", text: $display.name).foregroundColor(Color.gray).font(.system(size: 24, weight: .semibold)).frame(width: 175)
//                    Text("\(display.price, specifier: "$%.2f")").font(.custom("Helvetica Neue Bold", size: 22)).alignmentGuide(.leading) { d in d[.leading] }.padding(.trailing, 15).foregroundColor(Color(red: 237/240, green: 164/240, blue: 172/240))
//                }
//                else {
//                    TextField("", text: $display.name).font(.custom("Helvetica Neue", size: 19))
//                        .foregroundColor(.gray).frame(width: 150).disabled(true)
//                    Text("\(display.price, specifier: "$%.2f")").font(.custom("Helvetica Neue", size: 19))
//                    .minimumScaleFactor(0.0001)
//                        .lineLimit(1).foregroundColor(Color(red: 237/240, green: 164/240, blue: 172/240)).frame(width: 50).padding(.leading, 25)
//                }
//            }
//        }
//    }
//}
//
//struct ItemDisplay_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemDisplay(display: Item(payer: false, name: "Chicken", price: 29.50))
//    }
//}
