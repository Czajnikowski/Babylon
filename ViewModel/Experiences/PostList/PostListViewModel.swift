//
//  PostListViewModel.swift
//  ViewModel
//
//  Created by Maciek on 24/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Combine
import Networking
import View

public final class PostListViewModel {
    public var localizedAlertMessage: String? { error?.localizedAlertMessage }
    public var postRowStates: [PostRowState] { postDTOs.map(PostRowState.init) }
    
    @Published var error: BabylonError? = nil
    @Published private var postDTOs: [PostDTO] = []
    
    private var loadDataSubscriber: Cancellable?
    
    private let api: PostsDataPublishing
    private let didChangeDispatchQueue: DispatchQueue
    
    public init(api: PostsDataPublishing, didChangeDispatchQueue: DispatchQueue = .main) {
        self.api = api
        self.didChangeDispatchQueue = didChangeDispatchQueue
    }
    
    deinit {
        loadDataSubscriber?.cancel()
    }
}

extension PostListViewModel: PostListViewModelRepresenting, AlertMessageErrorConsuming {
    public func loadData() {
        loadDataSubscriber?.cancel()
        
        loadDataSubscriber = api
            .postsDataPublisher()
            .transform(to: [PostDTO].self, on: didChangeDispatchQueue)
            .sink(
                receiveCompletion: { [weak self] in
                    if case let .failure(error) = $0 {
                        self?.error = error
                    }
                },
                receiveValue: { [weak self] in
                    self?.postDTOs = $0
                }
            )
    }
}

extension PostListViewModel: PostProviding {
    public func providePost(forPostId postId: Int) -> PostDTO? {
        postDTOs.first { $0.id == postId }
    }
}

extension PostListViewModel: ViewObservableObject {
}
