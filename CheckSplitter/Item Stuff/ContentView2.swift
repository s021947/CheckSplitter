//
//  ContentView.swift
//  CheckSplitterApp
//
//  Created by Matthew Hillis on 5/4/21.
//

import UIKit
import Vision
import VisionKit
import SwiftUI
import MobileCoreServices
import AVFoundation

var OCR_RESULT: [String] = []

struct ContentView2: View {
    
    @State var ocrResult: [String] = OCR_RESULT
    var body: some View {
        ZStack {
            //DemoList(items: OrderArray, tax: Tax, tip: Tip)
            DemoList(ocrResult: $ocrResult)
        }
    }
    
    
}

class Item: Identifiable, Equatable, ObservableObject {
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
    

    let id = UUID()
    
    @Published var name: String
    @Published var payer: Bool
    @Published var money: Double
    @Published var hidden: Bool = false
    
    init(payer: Bool, name: String, money: Double) {
        self.name = name
        self.payer = payer
        self.money = money
    }
}

extension Double {
    var text: String {
        get {
            "$" + String(self)
        }
        set {
            self = Double(newValue) ?? 0
        }
    }
}

struct DisplayItem: View {
    
    @ObservedObject var display: Item
    
    var body: some View {
        //if !display.hidden {
            VStack(alignment: .leading) {
                HStack {
                    if (display.payer) {
                        TextField("", text: $display.name)
                            .foregroundColor(Color.gray)
                            .font(.system(size: 24, weight: .semibold))
                            .padding(.leading, 15)
                            //.frame(width: 175)
                        Text("\(display.money, specifier: "$%.2f")")
                            .font(.custom("Helvetica Neue Bold", size: 22))
                            .alignmentGuide(.leading) {
                                d in d[.leading]
                            }
                            .padding(.trailing, 15)
                            .foregroundColor(
                                Color(
                                    red: 237/240, green: 164/240, blue: 172/240
                                )
                            )
                    
                    } else {
                        TextField("", text: $display.name)
                            .font(.custom("Helvetica Neue", size: 18))
                            .foregroundColor(.gray)
                            //.frame(width: 150)
                            .padding(.leading, -25)
                            .disabled(true)
                        Spacer()
                        Text("\(display.money, specifier: "$%.2f")")
                            .font(.custom("Helvetica Neue", size: 18))
                            .minimumScaleFactor(0.0001)
                            .lineLimit(1)
                            .foregroundColor(
                                Color(
                                    red: 237/240, green: 164/240, blue: 172/240)
                                )
                            //.frame(width: 50)
                            .padding(.trailing, 15)
                    }
                }
            }
        //}
    }
}

func processOrder(order: [outputItem]) -> [Item] {
    var ret: [Item] = []
    
    for food in order {
        
        
        let itemToInsert = Item(payer: false, name: food.name, money: food.price)
        
        ret.append( itemToInsert )
    }
    
    return ret
}

struct ocrItem {
    var name: String?
    var price: Double?
    var amount: Int?
    
    var canBeItem: Bool {
        get {
            if let n = name, let p = price, let a = amount {
                if n != "" {
                     return true
                }
            }
            return false
        }
    }
    
    var hasName: Bool {
        get {
            if let n = name {
                return n != ""
            }
            
            return false
        }
    }
    init(name: String?, price: Double?, amount: Int?) {
        self.name = name
        self.price = price
        self.amount = amount
    }
}

struct outputItem {
    var name: String
    var price: Double
    
    init(name: String, price: Double) {
        self.name = name
        self.price = price
    }
}

struct DemoList: View {
    
    @State var updater: Bool = false
    @State private var isPresented = false
    @State var firstTime = true
    
    @State var actionFor: String = ""
    @State var itemIndex: Int = 0
    @State var itemDataIndex: Int = 0
    @State var itemOutput: [outputItem] = []
    @State var possibleItems: [ocrItem] = []
    
    @Binding var ocrResult: [String]
    
    @State var items: [Item] = []
    @State var tax: Double = 0
    @State var tip: Double = 0
    
    func processOcr(_ result: [String]) {
        
        self.items = []
        self.tax = 0
        self.tip = 0
        self.possibleItems = []
        self.itemOutput = []
        self.itemIndex = 0
        self.itemDataIndex = 0
        
        
        var itemList: [ocrItem] = []
        
        var possibleTax: [Double] = []
        var possibleTip: [Double] = []
        var guessNumbers: [Double] = []
        
        for rawItem in result {
            let item = rawItem.lowercased()

            if item.contains("tax") {
                if let x = Double( item.filter("0123456789.".contains) ) {
                    possibleTax.append(x)
                }
            } else if item.contains("tip") || item.contains("gratuity") {
                if let x = Double( item.filter("0123456789.".contains) ) {
                    possibleTip.append(x)
                }
            } else {
                let order = item.split(separator: " ")
                let number = Int( order[0].filter("0123456789.".contains) )
                let totalPrice = Double( order[order.count - 1].filter("0123456789.".contains) )
                
                var itemName = item
                    itemName.removeAll(where: { "$0123456789.".contains($0) })
                
                itemList.append(
                    ocrItem(
                        name: itemName.trimmingCharacters(in: .whitespacesAndNewlines),
                        price: totalPrice,
                        amount: number
                    
                    )
                )
            }
        }
        
        
        
        for someItem in itemList {
            
            if let amount = someItem.amount {
                guessNumbers.append(Double(amount))
            }
            if let price = someItem.price {
                guessNumbers.append(price)
            }
            
            if someItem.hasName {
                if someItem.canBeItem {
                    let name = someItem.name!
                    let price = someItem.price!
                    let amount = someItem.amount!
                    
                    if amount > 0 {
                        for _ in 1...amount {
                            itemOutput.append( outputItem( name: name, price: price / Double(amount) ) )
                        }
                    } else {
                        possibleItems.append(ocrItem(name: name, price: price, amount: nil))
                    }
                } else {
                    if let price = someItem.price {
                        possibleItems.append(ocrItem(name: someItem.name, price: price, amount: nil))
                    } else if let amount = someItem.amount {
                        possibleItems.append(ocrItem(name: someItem.name, price: nil, amount: amount))
                    }
                }
            }
        }
        
        
        print("lets get it")
        print(guessNumbers)
        
        actionQueue.append( {
                print("asking about order tax")
            self.showActionSheet(prompt: "Choose Order Tax", choices: possibleTax + guessNumbers, forAction: "tax")
        })
        
        
        actionQueue.append( {
            print("asking about order tip")
            self.showActionSheet(prompt: "Choose Order Tip", choices: possibleTip + guessNumbers, forAction: "tip")
        })
        
        //if let index = guessNumbers.firstIndex(of: finalTip) {
        //    guessNumbers.remove(at: index)
        //}
            
        var index = 0
        for possibleItem in possibleItems {
            if possibleItem.amount == nil {
                
                actionQueue.append( {
                
                    print("asking about item quantity")
                    self.itemIndex = index
                    self.itemDataIndex = 0
                    self.showActionSheet(prompt: "Choose \(possibleItem.name!) Quantity", choices: guessNumbers, forAction: "item")
                    
                })
                
            } else {
                
                actionQueue.append( {
                    self.itemIndex = index
                    self.itemDataIndex = 1
                    self.showActionSheet(prompt: "Choose \(possibleItem.name!) Price", choices: guessNumbers, forAction: "item")
                })
                
            }
            
            index += 1
        }
        
        print(actionQueue)
        
        updater.toggle()

        
    }
    
        
//        [
//
//        Item(payer: false, name: "borger", money: 6.89),
//        Item(payer: false, name: "chikin", money: 5.89),
//        Item(payer: false, name: "soda", money: 12.89),
//        Item(payer: false, name: "beef", money: 13.07),
//        Item(payer: false, name: "ice cream", money: 3.36),
//        Item(payer: false, name: "ice cream", money: 3.36)
//
//        ]
    
    var totalPayers: Int {
        get {
            var x = 0
            
            for i in items {
                if i.payer { x += 1 }
            }
            
            return x
        }
    }
    
    var totalBill: Double {
        get {
            var x: Double = 0
            
            for i in items {
                if !i.payer { x += i.money }
            }
            
            return x
        }
    }
    
    @State var splitTaxEvenly: Bool = true
    @State var splitTipEvenly: Bool = true
    
    let scanner = ScannerView()
    
    
    func updateItems() {
        var money: Double = 0
        
        for item in self.items.reversed() {

            if !item.payer {
                money += item.money
            } else {
                
                var taxValue : Double = 0
                var tipValue : Double = 0
                
                if self.splitTaxEvenly {
                    taxValue = self.tax / Double(totalPayers)
                } else {
                    taxValue = money * tax / totalBill
                }
                
                if self.splitTipEvenly {
                    tipValue = tip / Double(totalPayers)
                } else {
                    tipValue = money * tip / totalBill
                }
                
                
                item.money = money + taxValue + tipValue
                money = 0
            }
        }
        
        print("items updated")
        
        updater.toggle()
    }
    
    func collapseItems(_ item: Item) {
        let index = self.items.firstIndex(of: item)!
        
        var temp = 0
        
        if (index + 1) < self.items.count {
            for i in (index + 1)...(self.items.count - 1) {
                if self.items[i].payer {
                    return
                } else {
                    self.items[i].hidden.toggle()
                    temp += 1
                }
            }
        }
        
        updater.toggle()
    }
    
    @State private var editMode = EditMode.active
    private static var count = 0
    @State var menuOpen: Bool = false

    @State var actionQueue: [() -> Void] = []
    
    @State var showingActionSheet: Bool = false
    @State var userChoice: Double? = 0 {
        didSet {
            print("userChoice changed")
            print(actionQueue)
            print(userChoice)
            
            //self.showingActionSheet = false
            
            if userChoice != nil {
                switch actionFor {
                case "tax":
                    self.tax = userChoice!
                case "tip":
                    self.tip = userChoice!
                case "item":
                    if itemDataIndex == 0 {
                        let amount = userChoice!
                        for _ in 1...Int(amount) {
                            itemOutput.append( outputItem(name: possibleItems[itemIndex].name!, price: possibleItems[itemIndex].price! / amount ) )
                        }
                    } else if itemDataIndex == 1{
                        let price: Double = userChoice!
                        for _ in 1...possibleItems[itemIndex].amount! {
                            itemOutput.append( outputItem(name: possibleItems[itemIndex].name!, price: price / Double(possibleItems[itemIndex].amount!) ) )
                        }

                    }
                    
                default:
                    print("potato")
                }
            }
            
            self.items = processOrder(order: itemOutput)
            
            askQuestion()
    
        }
    }
    
    func askQuestion() {
        
        self.showingActionSheet = false
        updater.toggle()
        
        self.showingActionSheet = true
        updater.toggle()
        
        self.showingActionSheet = false
        updater.toggle()
        
        if actionQueue.count > 0 {
            let x = actionQueue[0]
            //actionQueue.removeFirst()
            
            //x()
        }
        
        updater.toggle()
    }
    
    @State var selectedChoice: Double = 0
    @State var prompt: String = ""

    @State var choices: [Double] = []

    func showActionSheet(prompt: String, choices: [Double], forAction: String) {
        
        //self.showingActionSheet = false
        
        self.actionFor = forAction
        
        self.prompt = prompt
        self.choices = choices
        
        self.showingActionSheet = true
        
        updater.toggle()

    }
    
    var body: some View {
        ZStack {
            scanner
            NavigationView {
            //VStack {
                List {
                    ForEach(items) { item in
                        if !item.hidden {
                            DisplayItem(display: item).contextMenu {
                                if (item.payer) {
                                    Button(action: {
                                        if let index = self.items.firstIndex(of: item) {
                                            self.items.remove(at: index)
                                        }
                                
                                    }, label: {
                                        HStack {
                                            Text("Remove")
                                            Spacer()
                                            Image(systemName: "trash")
                                        }
                                    })
                                }
                            }
                            .deleteDisabled(!item.payer)
                            .moveDisabled(item.payer)
                            .onTapGesture(count: 1) {
                                if item.payer {
                                    self.collapseItems(item)
                                }
                            }
                        }
                    }
                    .onMove(perform: onMove)
                    .onDelete(perform: onDelete)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .listRowInsets(EdgeInsets())
                    .background(Color.white)
                    
                    //cameraButton
                    
                }
                .onAppear {
                    UITableView.appearance().separatorStyle = .none
                }
                .navigationBarTitle("My Order", displayMode: .large)
                .navigationBarItems(leading: settingsButton, trailing: cameraButton)
                .environment(\.editMode, $editMode)
                .listStyle(PlainListStyle())
                //.toolbar {
                  //  ToolbarItem(placement: .navigationBarLeading) {
                        
                  //  }
               // }
            }
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    addButton
                    //.cornerRadius(38.5)
                    .padding(.trailing, 25)
                    .shadow(color: Color.black.opacity(0.3),
                            radius: 3,
                            x: 3,
                            y: 3)
                }
            }
            
            ZStack {
                GeometryReader { _ in
                    EmptyView()
                }
                .background(Color.gray.opacity(0.3))
                .opacity(menuOpen ? 1.0 : 0.0)
                .animation(Animation.easeIn.delay(0.25))
                .onTapGesture {
                    self.openMenu()
                    self.updater.toggle()
                }.edgesIgnoringSafeArea(.all)
                
                HStack {
                    List {
                       // Toggle("Split tax evenly", isOn: $splitTaxEvenly)
                           // .toggleStyle(SwitchToggleStyle(tint: Color.orange))
                           // .onChange(of: splitTaxEvenly) { value in
                         //       updateItems()
                         //   }
                       // Toggle("Split tip evenly", isOn: $splitTipEvenly)
                        //    .toggleStyle(SwitchToggleStyle(tint: .orange))
                        //    .onChange(of: splitTipEvenly) { value in
                         //       updateItems()
                        //    }
                        Button("run actionqueue") {
                            self.askQuestion()
                            
                        }
                        
                        Button("print actionqueue") {
                            print(self.actionQueue)
                            
                        }
                        
                        Button("toggle actionSheet") {
                            self.showingActionSheet.toggle()
                            
                        }
                        
                        Button("print actionsheet") {
                            print(self.showingActionSheet)
                            
                        }
                    }
                    .frame(width: 270)
                    .background(Color.white)
                    .offset(x: menuOpen ? 0 : -270)
                    .animation(.default)
                    
                    Spacer()
                }
            }
        }
        .onAppear() {
            if !self.firstTime {
                self.processOcr(OCR_RESULT)
                
                if self.actionQueue.count > 0 {
                    let x = self.actionQueue[0]
                    //self.actionQueue.remove(at: 0)
                    
                    //x()
                }
                
                
            } else {
                self.firstTime = false
            }
            
        }
        .actionSheet(isPresented: self.$showingActionSheet) {
            
            ActionSheet(title: Text(self.prompt), buttons:

                choices.map { choice in
                    .default(Text("\(choice, specifier: "$%.2f")")) {
                        
                        self.userChoice = choice
                        
                        self.showingActionSheet.toggle()
                        self.showingActionSheet.toggle()
                        self.showingActionSheet.toggle()
                        self.updater.toggle()
                        
                        
                        
                        
                        
                        
                    }
                }
            )
            
        }.animation(.easeInOut)
        
//        .onChange(of: ocrResult) {
//            updater.toggle()
//        }
    }
    
    func openMenu() {
        self.menuOpen.toggle()
    }
    
    private var settingsButton: some View {
        
        Button(action: {
            self.openMenu()
        }, label: {
            Image(systemName: "gear")
        })
        
    }
    
    private var cameraButton: some View {
        
        //ScannerView()
        //    .padding(.trailing, 25)
        
        Button(action: {
            self.scanner.docScan()
        }) {
            Image(systemName: "camera")
        }
        
        
        
    }
    
    private var addButton: some View {
        Button(action: onAdd) {
            Image("plusIcon")
                .renderingMode(.original)
                .resizable()
                .frame(width: 70, height: 70)
        }

    }
    
    private func onDelete(offsets: IndexSet) {
        let index = offsets.map{$0}[0]
        
        if items[index].payer {
            items.remove(atOffsets: offsets)
        }
        
        updateItems()
        updater.toggle()
    }
    
    private func onMove(source: IndexSet, destination: Int) {
        
        let index = source.map{$0}[0]
        
        if !items[index].payer {
        
            items.move(fromOffsets: source, toOffset: destination)
            
        }
        
        updateItems()
        updater.toggle()
        

    }
    
    private func onAdd() {
        
        //print("added")
        //userChoice = nil
        
        items.append(
            Item(payer: true, name: "Payer \(Self.count + 1)", money: 0)
        )
        Self.count += 1
        
        updateItems()
        updater.toggle()
    }

}


class ScanImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 7.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.systemIndigo.cgColor
        backgroundColor = UIColor.init(white: 1.0, alpha: 0.1)
        clipsToBounds = true
    }
}

class OcrTextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: .zero, textContainer: textContainer)
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 7.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.systemTeal.cgColor
        font = .systemFont(ofSize: 16.0)
    }
}


class ScanButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        setTitle("Scan", for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        titleLabel?.textColor = .white
        //layer.cornerRadius = 7.0
        backgroundColor = UIColor.systemIndigo
    }
}


class ViewController: UIViewController {
    
    private var scanButton = ScanButton(frame: .zero)
    private var scanImageView = ScanImageView(frame: .zero)
    private var ocrTextView = OcrTextView(frame: .zero, textContainer: nil)
    private var ocrRequest = VNRecognizeTextRequest(completionHandler: nil)
    
    private var firstTime = true
    
    func activate() {
        scanButton.sendActions(for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        configureOCR()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //if firstTime {
        //    scanButton.sendActions(for: .touchUpInside)
        //    firstTime = false
        //
        //}
    }

    
    private func configure() {
//        view.addSubview(scanImageView)
//        view.addSubview(ocrTextView)
        view.addSubview(scanButton)
        
        let padding: CGFloat = 0
        NSLayoutConstraint.activate([
            scanButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            //scanButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            //scanButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            //scanButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, constant: -padding),
            
//            ocrTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
//            ocrTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
//            ocrTextView.bottomAnchor.constraint(equalTo: scanButton.topAnchor, constant: -padding),
//            ocrTextView.heightAnchor.constraint(equalToConstant: 200),
//
//            scanImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
//            scanImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
//            scanImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
//            scanImageView.bottomAnchor.constraint(equalTo: ocrTextView.topAnchor, constant: -padding)
        ])
        
        scanButton.addTarget(self, action: #selector(scanDocument), for: .touchUpInside)
        
        
        
    }
    
    
    @objc func scanDocument() {
        
        print("SCANNING DOCUMENT")
        
        let scanVC = VNDocumentCameraViewController()
        scanVC.delegate = self
        present(scanVC, animated: true)
    }
    
    
    private func processImage(_ image: UIImage) {
        guard let cgImage = image.cgImage else { return }

        ocrTextView.text = ""
        scanButton.isEnabled = false
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try requestHandler.perform([self.ocrRequest])
        } catch {
            print(error)
        }
    }

    
    private func configureOCR() {
        ocrRequest = VNRecognizeTextRequest { (request, error) in
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            
            var ocrText = [String]()
            for observation in observations {
                guard let topCandidate = observation.topCandidates(1).first else { return }
                
                ocrText.append( topCandidate.string )
            }
            OCR_RESULT = ocrText
            print("ocrtext transferred")
            

            DispatchQueue.main.async {
                //self.ocrTextView.text = ocrText
                self.scanButton.isEnabled = true
            }
            
//            finalOrder["tip"]?.append(0)
//            finalOrder["tax"]?.append(0)
//
//
//            DEMOLIST.OrderArray = processOrder(order: finalOrder)
//            DEMOLIST.tip = finalOrder["tip"]?[0] as? Double ?? 0
//            DEMOLIST.tax = finalOrder["tax"]?[0] as? Double ?? 0
//
//
//            DEMOLIST.showActionSheet(prompt: "Choose Order Tax", choices: Order["tax"] as! [Double])
            
        }
        
        ocrRequest.recognitionLevel = .accurate
        ocrRequest.recognitionLanguages = ["en-US"]
        ocrRequest.usesLanguageCorrection = false
    }
    
    
}

extension ViewController: VNDocumentCameraViewControllerDelegate {
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        guard scan.pageCount >= 1 else {
            controller.dismiss(animated: true)
            return
        }
        
        scanImageView.image = scan.imageOfPage(at: 0)
        processImage(scan.imageOfPage(at: 0))
        controller.dismiss(animated: true)
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        //Handle properly error
        controller.dismiss(animated: true)
    }
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        controller.dismiss(animated: true)
    }
}








struct ScannerView: UIViewControllerRepresentable {

    typealias UIViewControllerType = UIViewController
    
    let view = ViewController()
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        return view
    }
        

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
    }
    
    func docScan() {
        view.activate()
    }
    
}

struct ScanButtonRepresentable: UIViewRepresentable {
    typealias UIViewType = UIButton
    
    func makeUIView(context: Context) -> UIViewType {
        return ScanButton(frame: .zero)
    }
    
    func updateUIView(_ uiViewController: UIViewType, context: Context) {
            
    }
}
