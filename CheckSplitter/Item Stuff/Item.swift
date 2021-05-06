////
////  Item.swift
////  CheckSplitter
////
////  Created by Krzysztof Jarocha (student LM) on 5/4/21.
////  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
////
//
//import Foundation
//class Item: Identifiable, Equatable, ObservableObject {
//    static func == (lhs: Item, rhs: Item) -> Bool {
//        return lhs.id == rhs.id
//    }
//    
//
//    let id = UUID()
//    
//    @Published var name: String
//    @Published var payer: Bool
//    @Published var price: Double
//    
//    init(payer: Bool, name: String, price: Double) {
//        self.name = name
//        self.payer = payer
//        self.price = price
//    }
//}
