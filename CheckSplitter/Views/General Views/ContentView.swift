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
    @State var payer: Payer = Payer()
    @State var payers: [Payer] = [Payer(), Payer(), Payer()]
    @State var cart: [FoodItem] = [FoodItem(), FoodItem(), FoodItem()]
    @State var item: FoodItem = FoodItem()
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .top){
           
            //creates a gradient background
            LinearGradientView()
                
                VStack(alignment: .center) {
                //button that allows user to select or take a picture of the bill
                Spacer()
                //display the actual image of the bill, if no image then show a placeholder photo
                Image(uiImage: billimage ?? UIImage(named: "placeholder")!).resizable().frame(width: 256, height: 256).clipShape(Circle())
                
                Button("Choose a Picture"){
                    self.showSheet = true
                    }.padding().foregroundColor(Color.white).font(.system(size: 32, weight: .semibold, design: .default)).actionSheet(isPresented: $showSheet) {
                                      ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [//when the user presses the button they will get the option to either tkae a photo or use one from the photo library
                                          .default(Text("Photo Library")) {
                                              self.showImagePicker = true
                                              self.sourceType = .photoLibrary
                                          },//depending on the choice selected, set the source type to the choice chosen
                                          .default(Text("Camera")) {
                                              self.showImagePicker = true
                                              self.sourceType = .camera
                                          },
                                          .cancel()//gives cancel option
                                      ])
                }.sheet(isPresented: $showImagePicker){
                    ImagePicker(billimage: self.$billimage, isShown: self.$showImagePicker, sourceType: self.sourceType)//allows the user to select an image by calling the ImagePicker file
                }
                //nagivation link to PayerList if the tag has the appriopriate value
                    NavigationLink(destination: PayerList(payers: $payers), tag: "PayerList", selection: $selection) { EmptyView()}
                //nagivation link to ItemView if the tag has the appriopriate value
                    NavigationLink(destination: ItemView(item: $item, cart: $cart, payers: $payers), tag: "ItemView", selection: $selection) { EmptyView()}
                //nagivation link to ItemView if the tag has the appriopriate value
                    NavigationLink(destination: PayView(payers: $payers), tag: "PayView", selection: $selection) { EmptyView()}

                
                VStack(spacing: 25){
                //button that leads to PayerDetail
                Button(action: {
                    self.selection = "PayerList"
                }){
                ButtonView(buttonText: "Enter Payer Info", buttonColor: Color.blue)
                }
                //button that leads to ItemView
                Button(action: {
                    self.selection = "ItemView"
                }){
                ButtonView(buttonText: "Assign Items", buttonColor: Color.black)
                }
                //button that leads to PayView
                Button(action: {
                    self.selection = "PayView"
                }){
                    ButtonView(buttonText: "Add Tax & Tip", buttonColor: Color.green)
                }
                //button that takes the user to a final display of the app
                Button(action: {
                    //create final menu that shows how much each user is due and why
                    
                }){
                    ButtonView(buttonText: "Final Info", buttonColor: Color.yellow)
                    }
                
                }
                }.navigationBarTitle("Check Splitter", displayMode: .automatic).navigationBarHidden(true)//hide navigation bar to allow for cleaner formating
    }
        }
}
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
