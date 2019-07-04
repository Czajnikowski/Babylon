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
            let postListViewModel = PostListViewModel(api: api)
            
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = PostListViewBuilder.build(
                viewModel: postListViewModel,
                detailsViewModelForPostIdProvider: { [unowned self, unowned postListViewModel]
                    postId -> PostDetailsViewModel? in
                    
                    guard let post = postListViewModel
                        .providePost(forPostId: postId) else { return nil }
                    
                    return PostDetailsViewModel(
                        post: post,
                        api: self.api
                    )
                }
            )
                .wrappedInHostingController
            
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
