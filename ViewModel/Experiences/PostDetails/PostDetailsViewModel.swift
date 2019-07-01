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
                description: post.body,
                numberOfComments: numberOfComments ?? 0
            )
        }
    }
    
    var sendChange = PassthroughSubject<Void, Never>()
    
    private var loadDataSubscriber: Cancellable?
    
    private let api: APIProviding
    private let didChangeDispatchQueue: DispatchQueue = .main
    
    private let post: PostDTO
    private var user: UserDTO?
    private var numberOfComments: Int?
    
    init(post: PostDTO, api: APIProviding) {
        self.post = post
        self.api = api
    }
}

extension PostDetailsViewModel: PostDetailsViewModelRepresenting {
    func loadData() {
        loadDataSubscriber?.cancel()
        
        loadDataSubscriber = Publishers
            .Zip(loadUser(), loadComments())
            .sink(
                receiveCompletion: { [weak self] in
                    if case let .failure(error) = $0 {
                        self?.error = error
                    }
                },
                receiveValue: { [weak self] (user, numberOfComments) in
                    self?.user = user
                    self?.numberOfComments = numberOfComments
                    
                    self?.sendChange.send()
                }
        )
    }
    
    private func loadUser() -> AnyPublisher<UserDTO, BabylonError> {
        return api
            .userDataPublisher(forUserWithId: post.userId)
            .mapError { return $0.toBabylonError(.networking) }
            .decode(type: UserDTO.self, decoder: JSONDecoder())
            .mapError { $0.toBabylonError(.parsing) }
            .receive(on: didChangeDispatchQueue)
            .eraseToAnyPublisher()
    }
    
    private func loadComments() -> AnyPublisher<Int, BabylonError> {
        return api
            .commentDataPublisher(forPostWithId: post.id)
            .mapError { return $0.toBabylonError(.networking) }
            .decode(type: [CommentDTO].self, decoder: JSONDecoder())
            .mapError { $0.toBabylonError(.parsing) }
            .map { $0.count }
            .receive(on: didChangeDispatchQueue)
            .eraseToAnyPublisher()
    }
}

extension PostDetailsViewModel: ChangeSending {
}
