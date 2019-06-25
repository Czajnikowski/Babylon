//
//  SceneDelegate.swift
//  Babylon
//
//  Created by Maciek on 25/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import UIKit
import View

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
        ) {
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            window.rootViewController = PostListExperienceBuilder.buildViewController(
                viewModel: PostListViewModel()
            )
            
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
