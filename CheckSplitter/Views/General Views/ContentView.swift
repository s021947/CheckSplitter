//
//  ContentView.swift
//  CheckSplitter
//
//  Created by Krzysztof Jarocha (student LM) on 3/11/21.
//  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //creates the necessary states to allow for image capture/selection
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var billimage: UIImage?
    
    //creates ability to go to different screens from home screens via nagivationview through selection variable which has a different string value for all views
    @State private var selection: String? = nil

    //creates all of the necessary variables for the project, ContentView is single source of truth for all variables
    @ObservedObject var payer: Payer = Payer()
    @State var payers: [Payer] = [Payer(), Payer(), Payer()]
    @State var cart: [FoodItem] = [FoodItem(), FoodItem(), FoodItem()]
    @State var item: FoodItem = FoodItem()
    //States for Setting View
    @State var modal = false
    @State var taxEvenSplit = true
    @State var tipEvenSplit = true
    var body: some View {
        ZStack{
            VStack(spacing: 20){
                    //Custom top bar of the that dispays the welcome text and a seeting icon which leads to a settings view
                     HStack{
                        //top text
                         Text("My Order").bold().font(.custom("Helvetica Neue", size: 22)).multilineTextAlignment(.leading).padding(.trailing, 150).padding(.top, 15).foregroundColor(Color(red: 85 / 255, green: 85 / 255, blue: 85/255))
                        //text to indicate the gear is a settings option
                        Text("Settings:")
                         //Custom Gear Icon that leads to Settings View
                         Button(action: {
                            print("settings button pressed")
                            self.modal.toggle()
                         }) {
                            Image("gear").resizable().frame(width: 32.0, height: 32.0).padding(.top,15).padding(.trailing,10).foregroundColor(Color.black)
                         }.sheet(isPresented: $modal){
                            SettingView(taxEvenSplit: self.$taxEvenSplit, tipEvenSplit: self.$tipEvenSplit, modal: self.$modal)
                            //.clearModalBackground()
                         }
                     }
                    //Rectangle Line that seperates view header from the list of payers
                     Rectangle()
                         .fill(Color(red: 170 / 255, green: 170 / 255, blue: 170/255))
                         .frame(width: UIScreen.main.bounds.width-38, height: 1)
                     
                    //ScrooView of all PayCards that shows each of the payers and allows for the addition of new payers
                     ScrollView{
                        //display each payer in the Payer array
                     ForEach(0..<payers.count, id: \.self) { i in
                        PayCard(payer: self.$payers[i], payers: self.$payers)
                     }
                    }
                    //when plus icon is pressed add new default payer to the list of existing payers
                     Button(action: {
                        self.payers.append(Payer(name: "", amount: 0.0, index: self.payers.count))                     })
                     {
                         Image("plusIcon").resizable().scaledToFit().frame(width: 44, height: 44).padding(.top, 20)
                     }.buttonStyle(PlainButtonStyle())
                    
                     Spacer()
                     //camera button that leads to Image scan and OCR recognition code when pressed
                     Button(action: {
                        //ViewController()
                     }) {
                         Image("picButton").resizable().scaledToFit().frame(width: 100, height: 100).padding(.top, 20)
                     }.buttonStyle(PlainButtonStyle())
                     
                     
        
                 }
        }
                    
                //nagivation link to PayerList if the tag has the appriopriate value
                   // NavigationLink(destination: PayerList(payers: $payers), tag: "PayerList", selection: $selection) { EmptyView()}
                //nagivation link to ItemView if the tag has the appriopriate value
                  //  NavigationLink(destination: ItemView(item: $item, cart: $cart, payers: $payers), tag: "ItemView", selection: $selection) { EmptyView()}
                //nagivation link to ItemView if the tag has the appriopriate value
                   // NavigationLink(destination: PayView(payers: $payers), tag: "PayView", selection: $selection) { EmptyView()}
                //nagivation link to ItemView if the tag has the appriopriate value
                   // NavigationLink(destination: EndView(), tag: "EndView", selection: $selection) { EmptyView()}
                
                }
                
}
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
