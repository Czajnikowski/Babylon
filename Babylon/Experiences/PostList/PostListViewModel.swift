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
    var alertMessage: String? {
        didSet { sendChange() }
    }
    
    var rowModels = [PostRowModel]() {
        didSet { sendChange() }
    }
    
    var didChange = PassthroughSubject<PostListViewModel, Never>()
    
    private let api: API
    private var loadDataSubscriber: Cancellable?
    
    init(api: API) {
        self.api = api
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
    func reloadData() {
        loadDataSubscriber?.cancel()

        loadDataSubscriber = api
            .dataPublisher(for: "https://jsonplaceholder.typicode.com/posts")
            .decode(type: [PostDTO].self, decoder: JSONDecoder())
            .map { $0.map(PostRowModel.init) }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: {
                    if case let .failure(error) = $0 {
                        self.alertMessage = "\(error)"
                    }
                },
                receiveValue: { [weak self] in
                    self?.rowModels = $0
                }
            )
    }
}
