//
//  ItemView.swift
//  CheckSplitter
//
//  Created by Krzysztof Jarocha (student LM) on 4/19/21.
//  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
//

import SwiftUI
//View that displays all of the food items from the photo of the bill provided from the user
//Allows user to assign people to each bill item, displays price as well
struct ItemView: View {
    //create bindings for necessary objects to display and assign all of the needed objects
    @Binding var cart: [FoodItem]
    @Binding var payers: [Payer]
    //state that will allow the user to be taken to the correct ListView based on which assign button they click
    @State var selection: String?
    //holder variable for the price of the current food item
    @State var price: Double = 0
    //Environment variable used to dismiss the view
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationView{
        ZStack{
        //creates gradient background
            LinearGradientView()
            ScrollView(){
            VStack(spacing: 20){
                Text("")
                Text("")
                Spacer()
                ForEach(cart.indices, id: \.self) { i in
                    FoodDisplay(item: self.$cart[i])//loops through every index of the contacts array and for every index i create a new card with information from contacts array
                }
                //NavigationLink that takes the user to the ListView of Food Items
                NavigationLink(destination: ListView(payers: $payers, price: self.$price), tag: "ListView", selection: self.$selection) { EmptyView()}
                //NavigationLink that takes the user back to ContentView
                NavigationLink(destination: ContentView(), tag: "ContentView", selection: self.$selection) { EmptyView()}
            Spacer()
            //returns user to home screen
            //Button(action: {
                //self.selection = "ContentView"
                //self.presentationMode.wrappedValue.dismiss()
            //}){
            //ButtonView(buttonText: "Home Screen", buttonColor: Color.blue)
            //}
        }
            }.background(LinearGradientView()).frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        }.navigationBarHidden(true)
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(cart: Binding.constant([FoodItem]()), payers: Binding.constant([Payer]()))
    }
}
