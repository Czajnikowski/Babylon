//
//  PostDetailsViewModel.swift
//  ViewModel
//
//  Created by Maciek on 01/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Combine
import View

public final class PostDetailsViewModel {
    public var localizedAlertMessage: String? { error?.localizedAlertMessage }
    public var state: PostDetailsViewState? {
        user.map {
            PostDetailsViewState(
                author: $0.username,
                description: post.body,
                numberOfComments: numberOfComments ?? 0
            )
        }
    }
    
    @Published var error: BabylonError? = nil
    
    private var loadDataSubscriber: Cancellable?
    
    private let post: PostDTO
    private var user: UserDTO?
    private var numberOfComments: Int?
    
    private let api: UserDataPublishing & CommentDataPublishing
    private let didChangeDispatchQueue: DispatchQueue = .main
    
    public init(post: PostDTO, api: UserDataPublishing & CommentDataPublishing) {
        self.post = post
        self.api = api
    }
}

extension PostDetailsViewModel: PostDetailsViewModelRepresenting, AlertMessageErrorConsuming {
    public func loadData() {
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
                    guard let strongSelf = self else { return }
                    
                    strongSelf.objectWillChange.send()
                    
                    strongSelf.user = user
                    strongSelf.numberOfComments = numberOfComments
                }
        )
    }
    
    private func loadUser() -> AnyPublisher<UserDTO, BabylonError> {
        api
            .userDataPublisher(forUserWithId: post.userId)
            .transform(to: UserDTO.self, on: didChangeDispatchQueue)
    }
    
    private func loadComments() -> AnyPublisher<Int, BabylonError> {
        api
            .commentDataPublisher(forPostWithId: post.id)
            .transform(to: [CommentDTO].self, on: didChangeDispatchQueue)
            .map { $0.count }
            .eraseToAnyPublisher()
    }
}

extension PostDetailsViewModel: ViewObservableObject {
}
