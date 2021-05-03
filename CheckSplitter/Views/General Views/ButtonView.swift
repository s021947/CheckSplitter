//
//  ButtonView.swift
//  CheckSplitter
//
//  Created by Krzysztof Jarocha (student LM) on 4/15/21.
//  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
//

import SwiftUI

struct ButtonView: View {
    //varaibles for the ButtonView
    var buttonText = "Hello"
    var buttonColor = Color.red
    
    var body: some View {
        ZStack{
            //creates a round rectangle button apperance for each button in the app
            RoundedRectangle(cornerRadius: 10).frame(width: 250, height: 50).foregroundColor(Color.gray)
            Text(buttonText).font(.system(size: 24, weight: .semibold, design: .default)).foregroundColor(Color.white)
            
            //adds the left side colored part of the button for customization
            //Corner().trim(from: 0.41, to: 0.59).foregroundColor(buttonColor).frame(width: 250, height: 50)
            

        }
    }
}
//creates a new struct to define the corner of the Rectangle
struct Corner: Shape {
    func path(in rect: CGRect) -> Path{
        var path = Path()
        path.addRoundedRect(in: rect, cornerSize: CGSize(width: 10, height: 10))
        return path
    }
}


struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
