//
//  PayCard.swift
//  CheckSplitter
//
//  Created by Krzysztof Jarocha (student LM) on 4/27/21.
//  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
//

//

import SwiftUI

struct PayerCard: View {
    //binding to the payer and array of payers
    @Binding var payer: Payer
    @Binding var payers: [Payer]
    //State that detects if a PayCard has been enpanded or not, with initial value equaling false
    @State var isexpanded: Bool = false
    //States that detects the index of a delected item, and the Food Items belonging to that payer
    @State var removedIndex: Int = 0
    @State var removedItems: [FoodItem] = []
    var body: some View {
        HStack{
       //top divider line for each PayCard
        //Rectangle().fill(Color.gray).frame(width: UIScreen.main.bounds.width, height: 122)
            //Divider().padding(.bottom, 100)
         //Rectangle().fill(Color.white).frame(width: UIScreen.main.bounds.width, height: 120)
            //Divider().padding(.top, 100)
            //calls the content of the view
            content
            Spacer()
        }.contentShape(Rectangle())
}
//provides the content for the view
 private var content: some View {
    VStack(alignment: .leading) {
        //displays delete feature as long as this payer is not the first payer in the payers array
        if self.payer.index != 0{
            //button tht when pressed removes the selected payer from the array of payers
            Button(action: {
                //set the removedIndex value to the index of the payer that was selected for deletion
                self.removedIndex = self.payer.index
                //set the items belonging to the removed payer equalt to this holding variable
                self.removedItems = self.payer.items
               
                //remove payer at chosen index as long as there is more than one index in the payer array
                    self.payers.remove(at: self.payer.index)
                
                //adjust the index values of all the payers in the payers array
                for payer in self.payers{
                    //if any payer in the array had a higher index than the deleted payer than adjust their index value accordingly
                    if payer.index > self.removedIndex{
                        payer.index -= 1
                    }
                    print("\(payer.index)")
                }
                //append all of the items belonging to the deleted payer to the first payer in the array
                self.payers[0].appendItems(items: self.removedItems)
             }) {
                //display custom color minus sign as the label for the button
                Image(systemName: "minus").resizable().frame(width: 20, height: 4.5, alignment: .top).padding(.top,15).padding(.leading,335)
             }.buttonStyle(PlainButtonStyle()).foregroundColor(Color(red: 255/255, green: 178/240, blue: 134/255))
        }
        HStack{
            //text field that displays the custom payer name for each payer
            TextField("Payer Name", text: $payer.name).font(.custom("Helvetica Neue", size: 30)).alignmentGuide(.leading) { d in d[.leading] }.foregroundColor(Color.gray).padding(.leading, 30).padding(.bottom, 25)
            //shows the amount that each payer is due in custom color
            Text("$ \(payer.amount, specifier: "%.2f")").font(.custom("Helvetica Neue Bold", size: 30)).alignmentGuide(.leading) { d in d[.leading] }.padding(.trailing, 25).foregroundColor(Color(red: 237/240, green: 164/240, blue: 172/240)).padding(.bottom, 25)
                }
        //if the PayerCard is expanded then display the items assigned to a specific Payer
        if self.isexpanded{
            ItemView(cart: self.$payer.items)
            }
    }
}
}


struct PayerCard_Previews: PreviewProvider {
    static var previews: some View {
        PayerCard(payer: Binding.constant(Payer()), payers: Binding.constant([Payer()]))
    }
}

