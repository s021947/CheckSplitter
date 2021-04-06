//
//  ContentView.swift
//  CheckSplitter
//
//  Created by Krzysztof Jarocha (student LM) on 3/11/21.
//  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
        
        var body: some View {
            
            ZStack{
            
            //logo in back
            
            //button to scan check
            Rectangle()
            .foregroundColor(Color(red:0/255, green: 128/255, blue: 255/255))
            .edgesIgnoringSafeArea(.all)
                           
            Rectangle()
            .foregroundColor(Color(red: 228/255, green: 195/255, blue: 76/255))
            .rotationEffect(Angle(degrees: 45))
            .edgesIgnoringSafeArea(.all)
            .offset(x: 95, y: 70)
                
               // Rectangle()
              //  .foregroundColor(Color(red:0/255, green: 128/255, blue: 255/255))
                //.rotationEffect(Angle(degrees: 45))
                //.edgesIgnoringSafeArea(.all)
                //.offset(x: 100, y: 20)
            
            Text("Welcome").bold()
                
            
                
            }
           
               
                    
}
}
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
