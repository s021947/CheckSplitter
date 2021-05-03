//
//  CollapsibleView.swift
//  CheckSplitter
//
//  Created by Krzysztof Jarocha (student LM) on 5/3/21.
//  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
//

import SwiftUI
//strucut for the collapsed view that displays a generic content are pressed
struct CollapsibleView<Content: View>: View {
    //States for View
    @State var label: () -> PayCard
    @State var content: () -> Content
    @State private var collapsed: Bool = true
    
    var body: some View {
        VStack {
            Button(
                //when the label or the chevron is pressed the collpased variabled is toggled and the contents of the CollapsedView are displayed
                action: { self.collapsed.toggle() },
                label: {
                    HStack {
                        self.label()
                        Spacer()
                        Image(systemName: self.collapsed ? "chevron.down" : "chevron.up").resizable().scaledToFit().frame(width: 18, height: 18).foregroundColor(Color("orange1")).padding(.trailing, 42)
                    }
                    //.padding(.trailing, 42)//shifts the view to best location
                    .background(Color.white.opacity(0.01))
                }
            )
            .buttonStyle(PlainButtonStyle())//styles the button
            
            VStack {
                self.content()//displays whatever content the payer wants
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: collapsed ? 0 : .none)
            .clipped()
            .animation(.easeOut)
            .transition(.slide)//creates custom animations for when the button is clicked
        }
    }
}
