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
    public var alertMessage: String? { error?.alertMessage }
    public var postRowModels: [PostRowModel] { postDTOs.map(PostRowModel.init) }
    
    public var didChange = PassthroughSubject<PostListViewModel, Never>()
    
    var error: BabylonError? {
        didSet { sendChange() }
    }
    private var postDTOs: [PostDTO] = [] {
        didSet { sendChange() }
    }
    
    private var loadDataSubscriber: Cancellable?
    
    private let api: APIProviding
    private let didChangeDispatchQueue: DispatchQueue
    
    public init(api: APIProviding, didChangeDispatchQueue: DispatchQueue = .main) {
        self.api = api
        self.didChangeDispatchQueue = didChangeDispatchQueue
    }
    
    deinit {
        loadDataSubscriber?.cancel()
    }
    
    private func sendChange() {
        didChange.send(self)
    }
}

extension PostListViewModel: ViewBindableObject {
}

extension PostListViewModel: PostListViewModelRepresenting, AlertMessageErrorConsuming {
    public func loadData() {
        loadDataSubscriber?.cancel()
        
        loadDataSubscriber = api
            .postsDataPublisher()
            .mapError { $0.toBabylonError(.networking) }
            .decode(type: [PostDTO].self, decoder: JSONDecoder())
            .mapError { $0.toBabylonError(.parsing) }
            .receive(on: didChangeDispatchQueue)
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
