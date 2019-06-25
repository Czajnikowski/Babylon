//
//  AppDelegate.swift
//  Babylon
//
//  Created by Maciek on 25/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
        ) -> UISceneConfiguration {
        
        return UISceneConfiguration(
            name: "Default Configuration",
            sessionRole: connectingSceneSession.role
        )
    }
}
