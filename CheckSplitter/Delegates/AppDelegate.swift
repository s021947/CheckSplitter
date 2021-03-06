//
//  AppDelegate.swift
//  CheckSplitter
//
//  Created by Krzysztof Jarocha (student LM) on 3/11/21.
//  Copyright © 2021 Krzysztof Jarocha (student LM). All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point fsor customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        
        //customize nagivation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()

        
        
        let attrs: [NSAttributedString.Key: Any] = [//create customization of navigation bar color and font
            .foregroundColor: UIColor.white
            ,.font: UIFont.monospacedSystemFont(ofSize: 36, weight: .black)
        ]
        
        appearance.largeTitleTextAttributes = attrs
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

