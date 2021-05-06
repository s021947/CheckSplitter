//
//  SettingsView.swift
//  CheckSplitter
//
//  Created by Ryan Rossman (student LM) on 5/2/21.
//  Copyright © 2021 Ryan Rossman (student LM). All rights reserved.
//

import SwiftUI
//view that controls certain payment settings of the program
struct SettingView: View {
    //bindings to necesary states
    @Binding var taxEvenSplit : Bool
    @Binding var tipEvenSplit : Bool
    @Binding var modal: Bool
    @Binding  var tipPercentageString: String
    //creates a UISwitch
    let taxButt = UISwitch(frame: CGRect.zero)
    var body: some View {
        ZStack{
            //image that allows the user to dismiss this view if the x is pressed
            Image(systemName: "xmark").resizable().scaledToFit().frame(width: 15, height: 15).padding(.trailing, 290).foregroundColor(.gray).padding(.bottom, 150).padding(.trailing, 5)
            VStack{
            Button(action: {
                //dismisses view if this button is pressed
                self.modal = false
            }) {
                //allows the user to return to main screen if they click anywhere on the screen
                RoundedRectangle(cornerRadius: 10).frame(width: UIScreen.main.bounds.width-32, height: UIScreen.main.bounds.height+15).foregroundColor(Color.white.opacity(0.1))
            }.buttonStyle(PlainButtonStyle()).foregroundColor(Color.white.opacity(0.8)).frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            
            VStack{
                HStack{
                    //toggle for proportional tax spliting
                    Toggle(isOn: $taxEvenSplit, label:{
                        Text("Split Tax Proportionally").font(.custom("Helvetica Neue", size: 22)).foregroundColor(.gray).padding(.trailing, 15)
                    }) .foregroundColor(Color.blue).toggleStyle(ColoredToggleStyle(onColor: Color(red: 237/240, green: 164/240, blue: 172/240), offColor: .gray, thumbColor: .white))
                    //custom toggle color and style for this toggle
                    
                }

                HStack{
                    //toggle for proportional tip spliting
                    Toggle(isOn: $tipEvenSplit, label:{
                        Text("Split Tip Proportionally").font(.custom("Helvetica Neue", size: 22)).foregroundColor(.gray).padding(.trailing, 15)
                    }) .foregroundColor(Color.blue).toggleStyle(ColoredToggleStyle(onColor: Color(red: 237/240, green: 164/240, blue: 172/240), offColor: .gray, thumbColor: .white))
                    //custom toggle color and style for this toggle
                }
                HStack{
                    Text("Tip Percentage").font(.custom("Helvetica Neue", size: 22)).foregroundColor(Color.gray).frame(width: 150).padding(.leading, 40)
            TextField("Tip% ", text: self.$tipPercentageString).font(.custom("Helvetica Neue", size: 22)).foregroundColor(Color(red: 237/240, green: 164/240, blue: 172/240)).padding(.leading, 90)
                }
            }
        }
    }
}
//struct for the CustomToggleStyle of each toggle that is used in SettingsView
struct ColoredToggleStyle: ToggleStyle {
    //creates the necesary custom colors
    var onColor = Color(UIColor.green)
    var offColor = Color(UIColor.systemGray5)
    var thumbColor = Color.white
    //creates a default rectangle that includes a label and a toggle option
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.label // The text (or view) portion of the Toggle
            RoundedRectangle(cornerRadius: 16, style: .circular)
                .fill(configuration.isOn ? onColor : offColor)
                .frame(width: 50, height: 29)
                .overlay(
                    Circle()
                        .fill(thumbColor)
                        .shadow(radius: 1, x: 0, y: 1)
                        .padding(1.5)
                        .offset(x: configuration.isOn ? 10 : -10))
                .animation(Animation.easeInOut(duration: 0.2))//custom toggle animation
                .onTapGesture { configuration.isOn.toggle() }//toggles the toggle bar when tapped using tapGesture
        }
        .font(.title)
        .padding(.horizontal)//adds padding to each toggle bar
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(taxEvenSplit: Binding.constant(true), tipEvenSplit: Binding.constant(true), modal: Binding.constant(true), tipPercentageString: Binding.constant("20.0"))
    }
}
