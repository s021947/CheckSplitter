////
////  ContentView2.swift
////  CheckSplitter
////
////  Created by Krzysztof Jarocha (student LM) on 5/4/21.
////  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
////
//
//import SwiftUI
//
//struct OrderView: View {
//    
//    @State var updater: Bool = false
//    //the list of actual items, either payers or actual food items
//    @State private var items: [Item] = [
//        Item(payer: false, name: "borger", price: 6.89),
//        Item(payer: false, name: "chikin", price: 5.89),
//        Item(payer: false, name: "soda", price: 12.89),
//        Item(payer: false, name: "beef", price: 13.07),
//        Item(payer: false, name: "ice cream", price: 3.36)
//        ].sorted{
//            $0.name < $1.name
//    }
//    //update the amount of moey each payer is due
//    //this function will be called whenever there is any sort of movement or rearragement of food items, this allows for live updatings of payer prices
//    func updateItems() {
//        var price: Double = 0
//        for item in self.items.reversed() {
//            if !item.payer {
//                price += item.price
//            } else {
//                item.price = price
//                price = 0
//            }
//        }
//        updater.toggle()
//    }
//    //States required for the body view and following functions
//    @State private var editMode = EditMode.active
//    private static var count = 0
//    
//    //States required for ActionMenu
//    @State var showingActionSheet = false
//    @State var userChoice: [Double] = []
//    @State var choices: [Double] = [5,10,15,20]
//    
//    
//    //States for Setting View
//     @State var modal = false
//     @State var taxEvenSplit = true
//     @State var tipEvenSplit = true
//     @State var tipPercentageString: String = "20.0"
//    //displays the main view
//    var body: some View {
//        ZStack{
//         NavigationView {
//             VStack{
//             List{
//                 ForEach(items) { item in
//                    ItemDisplay(display: item).contextMenu {
//                         if (item.payer) {
//                             Button(action: {
//                                 if let index = self.items.firstIndex(of: item) {
//                                     self.items.remove(at: index)
//                                 }
//                             }, label: {
//                                 HStack {
//                                     Text("Remove")
//                                     Spacer()
//                                     Image(systemName: "trash")
//                                 }
//                             })
//                         }
//                     }
//                     .deleteDisabled(!item.payer)
//                     .moveDisabled(item.payer)
//                 }
//                 .onMove(perform: onMove)
//                 .onDelete(perform: onDelete)
//                 .padding(.bottom, 10)
//             }
//             .navigationBarTitle("My Order")
//             .navigationBarItems(trailing:
//            //Custom Gear Icon that leads to Settings View
//             Button(action: {
//                self.modal.toggle()
//             }) {
//                Image("gear").resizable().frame(width: 32.0, height: 32.0).padding(.top,15).padding(.trailing,10).foregroundColor(Color.black)
//             }.sheet(isPresented: $modal){
//                SettingView(taxEvenSplit: self.$taxEvenSplit, tipEvenSplit: self.$tipEvenSplit, modal: self.$modal, tipPercentageString: self.$tipPercentageString)//.clearModalBackground()
//                }
//             )
//             .environment(\.editMode, $editMode)
//             .frame(height: 450)
//                HStack{
//                    addButton.padding()
//                    ActionMenu(showingActionSheet: self.$showingActionSheet, userChoice: self.$userChoice, prompt: Binding.constant("Which number is the text?"), choices: self.$choices)
//                    Button(action:{
//                        print(self.userChoice)
//                    }){
//                        Text("Test")
//                    }
//                }
//             }
//             }
//             }
//    }
//
//    private var addButton: some View {
//        Button(action: onAdd) { Image("plusIcon").renderingMode(.original).resizable().scaledToFit().frame(width: 44, height: 44).padding(.top, 20)
// }
//    }
//    
//    private var addScan: some View{
//    Button(action: onAdd
//        ) { Image("picButton").renderingMode(.original).resizable().scaledToFit().frame(width: 44, height: 44).padding(.top, 20)
//    }
//    }
//    
//    private func onDelete(offsets: IndexSet) {
//        let index = offsets.map{$0}[0]
//        if items[index].payer {
//            items.remove(atOffsets: offsets)
//        }
//        updateItems()
//        updater.toggle()
//    }
//    
//    private func onMove(source: IndexSet, destination: Int) {
//        let index = source.map{$0}[0]
//        if !items[index].payer {
//            items.move(fromOffsets: source, toOffset: destination)
//        }
//        updateItems()
//        updater.toggle()
//    }
//    
//    private func onInsert(at offset: Int, itemProvider: [NSItemProvider]) {
//        for provider in itemProvider {
//            if provider.canLoadObject(ofClass: URL.self) {
//                _ = provider.loadObject(ofClass: URL.self) { url, error in
//                }
//            }
//        }
//        updateItems()
//        updater.toggle()
//    }
//    
//    private func onAdd() {
//        items.insert(
//            Item(payer: true, name: "Payer \(Self.count+1)", price: 0.00),
//            at: 0
//        )
//        Self.count += 1
//        updateItems()
//        updater.toggle()
//    }
//}
//
//struct OrderView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderView()
//    }
//}
//
////to make the settings menu transparent
//struct ClearBackgroundView: UIViewRepresentable {
//    func makeUIView(context: Context) -> some UIView {
//        let view = UIView()
//        DispatchQueue.main.async {
//            view.superview?.superview?.backgroundColor = .clear
//        }
//        return view
//    }
//    func updateUIView(_ uiView: UIViewType, context: Context) {
//    }
//}
//struct ClearBackgroundViewModifier: ViewModifier {
//    
//    func body(content: Content) -> some View {
//        content
//            .background(ClearBackgroundView())
//    }
//}
//extension View {
//    func clearModalBackground()->some View {
//        self.modifier(ClearBackgroundViewModifier())
//    }
//
//}
