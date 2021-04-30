//
//  FinalCard.swift
//  CheckSplitter
//
//  Created by Krzysztof Jarocha (student LM) on 4/29/21.
//  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
//

import SwiftUI

struct FinalCard: View {
    @State var empty: String = ""

    var body: some View {
        TextField("Final Payer Card", text: self.$empty).textFieldStyle(RoundedBorderTextFieldStyle()).disabled(true)
    }
}

struct FinalCard_Previews: PreviewProvider {
    static var previews: some View {
        FinalCard()
    }
}
