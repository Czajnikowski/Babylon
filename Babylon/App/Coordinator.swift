//
//  Coordinator.swift
//  Babylon
//
//  Created by Maciek on 04/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Networking
import UIKit
import View
import ViewModel

class Coordinator {
    private let window: UIWindow
    
    private let api: API = {
        let urlCache = URLCache(
            memoryCapacity: 4 * 1024 * 1024,
            diskCapacity: 20 * 1024 * 1024,
            diskPath: nil
        )
        URLCache.shared = urlCache
        
        return API(session: URLSession.shared)
    }()
    
    init(managing window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let postListViewModel = PostListViewModel(api: api)
        window.rootViewController = PostListViewBuilder(
            viewModel: postListViewModel,
            listDestinationViewBuilder: PostDetailsViewBuilder(
                viewModelForPostIdProvider: { [unowned self, unowned postListViewModel] in
                    self.providePostDetailsViewModel(postId: $0, postProvider: postListViewModel)
                }
            )
        )
            .buildView()
            .wrappedInHostingController
        
        window.makeKeyAndVisible()
    }
    
    private func providePostDetailsViewModel(
        postId: Int,
        postProvider: PostProviding
        ) -> PostDetailsViewModel? {
        
        guard let post = postProvider
            .providePost(forPostId: postId) else { return nil }
        
        return PostDetailsViewModel(
            post: post,
            api: self.api
        )
    }
}
