//
//  API.swift
//  Networking
//
//  Created by Maciek on 26/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Combine

public final class API {
    private let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    public func postsDataPublisher() -> AnyPublisher<Data, URLError> {
        dataPublisher(for: .posts)
    }
    
    public func userDataPublisher(forUserWithId userId: Int) -> AnyPublisher<Data, URLError> {
        dataPublisher(for: .user(userId: userId))
    }
    
    public func commentDataPublisher(forPostWithId postId: Int) -> AnyPublisher<Data, URLError> {
        dataPublisher(for: .comment(postId: postId))
    }
    
    private func dataPublisher(
        for endpoint: Endpoint,
        reloadCache: Bool = true
        ) -> AnyPublisher<Data, URLError> {
        
        guard let url = endpoint.url else {
            return Publishers
                .Fail(outputType: Data.self, failure: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        return session
            .dataTaskPublisher(for: .urlRequest(for: url))
            .catch { [unowned self] _ in
                self.session
                    .dataTaskPublisher(for: .urlRequest(for: url, reloadCache: false))
            }
            .map { data, _ in data }
            .eraseToAnyPublisher()
    }
}
