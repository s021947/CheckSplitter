//
//  DropDown.swift
//  CheckSplitter
//
//  Created by Krzysztof Jarocha (student LM) on 4/30/21.
//  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
//

import SwiftUI

struct DropDown: View {
    @Binding var selection: String?
    //toggle varaible for expansion of dropdown menu
    @State var expand = false
    var body: some View {
        ZStack(alignment: .leading){
            VStack(alignment: .leading, spacing: 10){
                HStack(alignment: .top){
                Image(systemName: "gear").font(.system(size: 36)).foregroundColor(Color.blue).padding()
                //change arrow depedning on state of expand bool
                Image(systemName: expand ? "chevron.up" : "chevron.down").resizable().frame(width: 18, height: 18).foregroundColor(Color.blue).onTapGesture {
                    self.expand.toggle()//toggle the menu on button press
                }
                }
                if expand{//if user has expanded the menu
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
                    //button that leads to EndView
                    Button(action: {
                        self.selection = "EndView"
                    }){
                        ButtonView(buttonText: "Final Info", buttonColor: Color.yellow)
                        }
                }
            }.animation(.spring())
        }
    }
}

struct DropDown_Previews: PreviewProvider {
    static var previews: some View {
        DropDown(selection: Binding.constant(String()))
    }
}
