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
    
    var rowModels: [PostRowModel] {
        return postDTOs.map(PostRowModel.init)
    }
    
    var didChange = PassthroughSubject<PostListViewModel, Never>()
    
    private var postDTOs: [PostDTO] = [] {
        didSet { sendChange() }
    }
    
    private var loadDataSubscriber: Cancellable?
    
    private let api: APIProviding
    private let didChangeReceivingQueue: DispatchQueue
    
    init(api: APIProviding, didChangeReceivingQueue: DispatchQueue = .main) {
        self.api = api
        self.didChangeReceivingQueue = didChangeReceivingQueue
    }
    
    deinit {
        loadDataSubscriber?.cancel()
    }
    
    private func sendChange() {
        didChange.send(self)
    }
}

extension PostListViewModel: ChangeReporting {
}

extension PostListViewModel: PostListViewModelRepresenting {
    func loadData() {
        loadData(using: api.loadedPostsDataPublisher())
    }
    
    func reloadData() {
        loadData(using: api.reloadedPostsDataPublisher())
    }
    
    private func loadData(using postsDataPublisher: AnyPublisher<Data, URLError>) {
        loadDataSubscriber?.cancel()
        
        loadDataSubscriber = postsDataPublisher
            .mapError { return $0.toBabylonError(.networking) }
            .decode(type: [PostDTO].self, decoder: JSONDecoder())
            .mapError { $0.toBabylonError(.parsing) }
            .receive(on: didChangeReceivingQueue)
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
