//
//  EndView.swift
//  CheckSplitter
//
//  Created by Krzysztof Jarocha (student LM) on 4/28/21.
//  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
//

import SwiftUI

struct EndView: View {
    var body: some View {
        ZStack{
            //custom background created
            LinearGradientView()
            ScrollView{
                VStack(spacing: 20){
                    Text("")
                    Text("")
                    Spacer()
                    Text("Show all Payers and how much they owe and for what Food Items, allow to go back a screen or restart the entire process. Also allow to save the digital recepit of the bill to photos or send to friends").foregroundColor(Color.white).font(.system(size: 36, weight: .semibold))
            //returns to home screen
            DismissView()
                }
            }.background(LinearGradientView()).frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct EndView_Previews: PreviewProvider {
    static var previews: some View {
        EndView()
    }
}
