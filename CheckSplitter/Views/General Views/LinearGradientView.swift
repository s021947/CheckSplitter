//
//  LinearGradientView.swift
//  CheckSplitter
//
//  Created by Krzysztof Jarocha (student LM) on 4/21/21.
//  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
//

import SwiftUI

struct LinearGradientView: View {
    var body: some View {
        //creates custom gradient background for all views with the two colors from our logo
         LinearGradient(gradient: Gradient(colors: [Color("orange1"), Color("pink1")]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
    }
}

struct LinearGradientView_Previews: PreviewProvider {
    static var previews: some View {
        LinearGradientView()
    }
}
