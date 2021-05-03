//
//  SettingsView.swift
//  CheckSplitter
//
//  Created by Ryan Rossman (student LM) on 5/2/21.
//  Copyright © 2021 Ryan Rossman (student LM). All rights reserved.
//

import SwiftUI

struct SettingView: View {
    @Binding var taxEvenSplit : Bool
    @Binding var tipEvenSplit : Bool
    let taxButt = UISwitch(frame: CGRect.zero)
    @Binding var modal: Bool
    
    
    var body: some View {
        
        
        ZStack{
            Image(systemName: "xmark").resizable().scaledToFit().frame(width: 15, height: 15).padding(.trailing, 290).foregroundColor(.gray).padding(.bottom, 105).padding(.trailing, 5)
            
            VStack{
            Button(action: {
                print("big button pressed")
                self.modal = false
            }) {
                RoundedRectangle(cornerRadius: 10).frame(width: UIScreen.main.bounds.width-32, height: UIScreen.main.bounds.height+15).foregroundColor(Color.white.opacity(0.1))
            }.buttonStyle(PlainButtonStyle()).foregroundColor(Color.white.opacity(0.8)).frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            
            VStack{
                
                
                
                HStack{
                    
                    
                    Toggle(isOn: $taxEvenSplit, label:{
                        Text("Split Tax Proportionally").font(.custom("Helvetica Neue", size: 22)).foregroundColor(.black).padding(.trailing, 15)
                    }) .foregroundColor(Color.blue).toggleStyle(ColoredToggleStyle(onColor: Color(red: 237/240, green: 164/240, blue: 172/240), offColor: .gray, thumbColor: .white))
                    
                    
                }
                
                HStack{
                    
                    
                    Toggle(isOn: $tipEvenSplit, label:{
                        Text("Split Tip Proportionally").font(.custom("Helvetica Neue", size: 22)).foregroundColor(.black).padding(.trailing, 15)
                    }) .foregroundColor(Color.blue).toggleStyle(ColoredToggleStyle(onColor: Color(red: 237/240, green: 164/240, blue: 172/240), offColor: .gray, thumbColor: .white))
                }
            }
        }
    }
}

struct ColoredToggleStyle: ToggleStyle {
    var onColor = Color(UIColor.green)
    var offColor = Color(UIColor.systemGray5)
    var thumbColor = Color.white
    
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.label // The text (or view) portion of the Toggle
            //Spacer()
            RoundedRectangle(cornerRadius: 16, style: .circular)
                .fill(configuration.isOn ? onColor : offColor)
                .frame(width: 50, height: 29)
                .overlay(
                    Circle()
                        .fill(thumbColor)
                        .shadow(radius: 1, x: 0, y: 1)
                        .padding(1.5)
                        .offset(x: configuration.isOn ? 10 : -10))
                .animation(Animation.easeInOut(duration: 0.2))
                .onTapGesture { configuration.isOn.toggle() }
        }
        .font(.title)
        .padding(.horizontal)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(taxEvenSplit: Binding.constant(true), tipEvenSplit: Binding.constant(true), modal: Binding.constant(true))
    }
}
