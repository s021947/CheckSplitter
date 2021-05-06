////
////  ActionMenu.swift
////  CheckSplitter
////
////  Created by Krzysztof Jarocha (student LM) on 5/4/21.
////  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
////
//
//import SwiftUI
//
//struct ActionMenu: View {
//    @Binding var showingActionSheet: Bool
//    @Binding var userChoice: [Double]
//    @Binding var prompt: String
//    
//    @Binding var choices: [Double]
//    
//    var body: some View {
//        Image("picButton").renderingMode(.original).resizable().scaledToFit().frame(width: 44, height: 44).padding(.top, 20).onTapGesture {
//            self.showingActionSheet = true
//        }.actionSheet(isPresented: self.$showingActionSheet){
//            showActionSheet(prompt: self.prompt, choices: self.choices)
//            }.animation(.easeInOut)
//    }
//    
//    //function
//    func showActionSheet(prompt: String, choices: [Double]) -> ActionSheet{
//        self.prompt = prompt
//        self.choices = choices
//        
//        return ActionSheet(title: Text(self.prompt), buttons:
//            choices.map { choice in
//                .default(Text("\(choice, specifier: "$%.2f")")) { self.userChoice.append(choice)
//                    //then call next one
//
//            }
//                } //+ .cancel()
//        )
//}
//    
//}
//
//struct ActionMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        ActionMenu(showingActionSheet: Binding.constant(false), userChoice: Binding.constant([0]), prompt: Binding.constant("User Prompt:"), choices: Binding.constant([5,10,15]))
//    }
//}
