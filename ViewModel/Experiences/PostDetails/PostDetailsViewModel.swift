//
//  PostDetailsViewModel.swift
//  ViewModel
//
//  Created by Maciek on 01/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Combine
import View

final class PostDetailsViewModel {
    var error: BabylonError? {
        didSet { sendChange.send() }
    }
    
    var state: PostDetailsViewState? {
        return user.map {
            PostDetailsViewState(
                author: $0.username,
                description: "None yet",
                numberOfComments: 0
            )
        }
    }
    
    var sendChange = PassthroughSubject<Void, Never>()
    
    private var loadDataSubscriber: Cancellable?
    
    private let post: PostDTO
    private let api: APIProviding
    private let didChangeDispatchQueue: DispatchQueue = .main
    
    private var user: UserDTO? {
        didSet { sendChange.send() }
    }
    
    init(post: PostDTO, api: APIProviding) {
        self.post = post
        self.api = api
    }
}

extension PostDetailsViewModel: PostDetailsViewModelRepresenting {
    func loadData() {
        loadDataSubscriber?.cancel()
        
        loadDataSubscriber = api
            .userDataPublisher(forUserWithId: post.userId)
            .mapError { return $0.toBabylonError(.networking) }
            .decode(type: UserDTO.self, decoder: JSONDecoder())
            .mapError { $0.toBabylonError(.parsing) }
            .receive(on: didChangeDispatchQueue)
            .sink(
                receiveCompletion: { [weak self] in
                    if case let .failure(error) = $0 {
                        self?.error = error
                    }
                },
                receiveValue: { [weak self] in
                    self?.user = $0
                }
        )
    }
}

extension PostDetailsViewModel: ChangeSending {
}
