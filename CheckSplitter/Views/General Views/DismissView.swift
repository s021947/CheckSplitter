//
//  DismissView.swift
//  CheckSplitter
//
//  Created by Krzysztof Jarocha (student LM) on 4/27/21.
//  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
//

import SwiftUI

struct DismissView: View {
    //Environment variable used to dismiss the view
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    //text that is displayed on the button that dismisses the view
    var text = "Home Screen"
    
    var body: some View {
        //button that returns the user to previous view
        Button(action: {
        //dismiss the current view immediately
            self.presentationMode.wrappedValue.dismiss()
        }){
        ButtonView(buttonText: text, buttonColor: Color.blue)
        }
    }
}

struct DismissView_Previews: PreviewProvider {
    static var previews: some View {
        DismissView()
    }
}
