////
////  ScanImageView.swift
////  DocScan
////
////  Created by Ryan Hillis on 03/03/2020.
////  Copyright © 2020 ImTech. All rights reserved.
////
//
//import UIKit
//Creates background view for the ViewController
//class ScanImageView: UIImageView {
//    //Rectangle initializer
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        configure()
//    }
//    //error handling
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func configure() {
//        //creates border for the ViewController
//        translatesAutoresizingMaskIntoConstraints = false
//        layer.cornerRadius = 7.0
//        layer.borderWidth = 1.0
//        layer.borderColor = UIColor.systemIndigo.cgColor
//        backgroundColor = UIColor.init(white: 1.0, alpha: 0.1)
//        clipsToBounds = true
//    }
//}
