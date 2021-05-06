////
////  ViewController.swift
////  DocScan
////
////  Created by Ryan HIllis on 27/02/2020.
////  Copyright © 2020 ImTech. All rights reserved.
////
//
//import UIKit
//import Vision
//import VisionKit
////class
//class ViewController: UIViewController {
//    
//    private var scanButton = ScanButton(frame: .zero)
//    private var scanImageView = ScanImageView(frame: .zero)
//    private var ocrTextView = OcrTextView(frame: .zero, textContainer: nil)
//    private var ocrRequest = VNRecognizeTextRequest(completionHandler: nil)
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        configure()
//        configureOCR()
//    }
//
//    
//    private func configure() {
//        view.addSubview(scanImageView)
//        view.addSubview(ocrTextView)
//        view.addSubview(scanButton)
//        
//        let padding: CGFloat = 16
//        NSLayoutConstraint.activate([
//            scanButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
//            scanButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
//            scanButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
//            scanButton.heightAnchor.constraint(equalToConstant: 50),
//            
//            ocrTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
//            ocrTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
//            ocrTextView.bottomAnchor.constraint(equalTo: scanButton.topAnchor, constant: -padding),
//            ocrTextView.heightAnchor.constraint(equalToConstant: 200),
//            
//            scanImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
//            scanImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
//            scanImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
//            scanImageView.bottomAnchor.constraint(equalTo: ocrTextView.topAnchor, constant: -padding)
//        ])
//        
//        scanButton.addTarget(self, action: #selector(scanDocument), for: .touchUpInside)
//    }
//    
//    
//    @objc private func scanDocument() {
//        let scanVC = VNDocumentCameraViewController()
//        scanVC.delegate = self
//        present(scanVC, animated: true)
//    }
//    
//    
//    private func processImage(_ image: UIImage) {
//        guard let cgImage = image.cgImage else { return }
//
//        ocrTextView.text = ""
//        scanButton.isEnabled = false
//        
//        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
//        do {
//            try requestHandler.perform([self.ocrRequest])
//        } catch {
//            print(error)
//        }
//    }
//
//    
//    private func configureOCR() {
//        ocrRequest = VNRecognizeTextRequest { (request, error) in
//            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
//            
//            var ocrText = [String]()
//            for observation in observations {
//                guard let topCandidate = observation.topCandidates(1).first else { return }
//                
//                ocrText.append( topCandidate.string )
//            }
//            
//            var Order: [String: [Any]] = [
//                "items": [],
//                "tax": [0],
//                "tip": [0]
//            ]
//            
//            for item in ocrText {
//                
//                print("found item")
//                print(item)
//                
////                if we think item is the total
////                    put this number as the guess for the total
////
////
////                if we think item is tax
////                    put this number as the guess for tax
////
////                if we think item is tip
////                    put this number as the guess for tip
////
////                if we think item is an order
////                    find the name quantity and price
////                add [name, actualPrice] to the order quantity # of times
//                
//            }
//            
////            loop through the order
////                if we don't know the tax, ask for the tax
////
////                if we don't know the tip, ask for the tip
////
////                if the order is not adding up,
////                    ask if the guess for tax is correct
////                    ask if the guess for tip is correct
////
////
////            check the Order
////                if it doesn't work, prompt user to enter everything manually or take another picture
//                    
//            
//            
//            
//            DispatchQueue.main.async {
//                //self.ocrTextView.text = ocrText
//                self.scanButton.isEnabled = true
//            }
//        }
//        
//        ocrRequest.recognitionLevel = .accurate
//        ocrRequest.recognitionLanguages = ["en-US"]
//        ocrRequest.usesLanguageCorrection = true
//    }
//}
//
//
//extension ViewController: VNDocumentCameraViewControllerDelegate {
//    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
//        guard scan.pageCount >= 1 else {
//            controller.dismiss(animated: true)
//            return
//        }
//        
//        scanImageView.image = scan.imageOfPage(at: 0)
//        processImage(scan.imageOfPage(at: 0))
//        controller.dismiss(animated: true)
//    }
//    
//    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
//        //Handle properly error
//        controller.dismiss(animated: true)
//    }
//    
//    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
//        controller.dismiss(animated: true)
//    }
//}
//
