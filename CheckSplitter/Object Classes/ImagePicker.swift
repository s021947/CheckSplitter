//
//  ImagePicker.swift
//  CheckSplitter
//
//  Created by Krzysztof Jarocha (student LM) on 4/15/21.
//  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
//

import Foundation
import SwiftUI

//creates an ImagePickerCoordinator
class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    //Binding to necessary variables to display the desired image
    @Binding var billimage: UIImage?
    @Binding var isShown: Bool
    
    //initialize image
    init(image: Binding<UIImage?>, isShown: Binding<Bool>){
        _billimage = image
        _isShown = isShown
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
        
        if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            billimage = uiImage//casts the billimage as a UIImage
            isShown = false
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false//if the user cancels do not show an image
    }
}



//delegates task to the imagecoordinator which selectes the image
struct ImagePicker: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIImagePickerController//sets the veiw to an ImagePIckerController which is a swiftui type which is used to manage pictues
    typealias Coordinator = ImagePickerCoordinator//implement coordinator in the struct
    
    @Binding var billimage: UIImage?
    @Binding var isShown: Bool
    var sourceType: UIImagePickerController.SourceType = .camera
    
    //function necessary if the picker is chaning, for our purpose this change never occurs so the function is left empty
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    //creates image coordinator
    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePickerCoordinator(image: $billimage, isShown: $isShown)
    }
    
    
    //creates a UIViewController to pick an image
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()//creates a picker controller
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
        
    }
}
