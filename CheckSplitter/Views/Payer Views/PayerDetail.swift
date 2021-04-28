//
//  PayerDetail.swift
//  CheckSplitter
//
//  Created by Krzysztof Jarocha (student LM) on 4/19/21.
//  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
//

import SwiftUI

//the view where a new payer can be added to the list of payers
struct PayerDetail: View {
    //binding to the array of payers and creates a new Payer state that can be changed added to the array of existing payers
    @State var payer : Payer = Payer()
    @Binding var payers : [Payer]
    //Environment used to dismiss the view
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack{
            //creates gradient background
             LinearGradientView()
            
            VStack{
                //displays an image of the payer
                Image("person").resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle()).frame(width: 256, height: 256, alignment: .center)
                
                Form{//creates a form to fill out for payer information
                    Section(header: Text("Payer Information").font(.system(size: 20))){
                        //creates text fields for the name and applepayid of the user
                        TextField("Name", text: $payer.name).font(.system(size: 36))
                        TextField("ApplePayId", text: $payer.applepayid).font(.system(size: 36))
                    }
                    

                }
                //button that performs the Add Payer functions
                Button(action: {
                   //add new payer to the list of payers
                    self.payers.append(self.payer)
                    
                //dismiss the view immediately
                    self.presentationMode.wrappedValue.dismiss()
                    
                }){
                ButtonView(buttonText: "Add Payer", buttonColor: Color.blue)
                }
            }
        }
    }
}

struct PayerDetail_Previews: PreviewProvider {
    static var previews: some View {
        PayerDetail(payers: Binding.constant([Payer()]))
    }
}
