//
//  SceneDelegate.swift
//  Babylon
//
//  Created by Maciek on 25/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Networking
import UIKit
import View
import ViewModel

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    private let api: API = {
        let urlCache = URLCache(
            memoryCapacity: 4 * 1024 * 1024,
            diskCapacity: 20 * 1024 * 1024,
            diskPath: nil
        )
        URLCache.shared = urlCache
        
        return API(session: URLSession.shared)
    }()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
        ) {
        
        if let windowScene = scene as? UIWindowScene {
            let postListViewModel = PostListViewModelBuilder.build(api: api)
            
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = PostListExperienceBuilder.buildViewController(
                viewModel: postListViewModel,
                postDetailsViewModelProvider: { [unowned self, unowned postListViewModel] postId in
                    
                    return PostDetailsViewModelBuilder.build(
                        post: postListViewModel.providePost(forPostId: postId),
                        api: self.api
                    )
                }
            )
            
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
