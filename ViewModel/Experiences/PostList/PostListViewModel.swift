//
//  PostListViewModel.swift
//  Controller
//
//  Created by Maciek on 24/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Combine
import Networking
import View

final class PostListViewModel {
    var error: BabylonError? {
        didSet { sendChange() }
    }
    
    var postRowModels: [PostRowModel] {
        return postDTOs.map(PostRowModel.init)
    }
    
    var didChange = PassthroughSubject<PostListViewModel, Never>()
    
    fileprivate var postDTOs: [PostDTO] = [] {
        didSet { sendChange() }
    }
    
    private var loadDataSubscriber: Cancellable?
    
    private let api: APIProviding
    private let didChangeDispatchQueue: DispatchQueue
    
    init(api: APIProviding, didChangeDispatchQueue: DispatchQueue = .main) {
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

extension PostListViewModel: PostListViewModelRepresenting {
    func loadData() {
        loadDataSubscriber?.cancel()
        
        loadDataSubscriber = api
            .postsDataPublisher()
            .mapError { return $0.toBabylonError(.networking) }
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
    func providePost(forPostId postId: Int) -> PostDTO {
        return postDTOs.first { $0.id == postId }!
    }
}
