//
//  Networking.swift
//  Networking
//
//  Created by Maciek on 26/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Combine

private enum Endpoint {
    case
    posts
    
    var urlString: String {
         return "https://jsonplaceholder.typicode.com/posts"
    }
}

public final class API {
    private let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    public func loadedPostsDataPublisher() -> AnyPublisher<Data, URLError> {
        return dataPublisher(for: .posts, reloadCache: false)
    }
    
    public func reloadedPostsDataPublisher() -> AnyPublisher<Data, URLError> {
        return dataPublisher(for: .posts, reloadCache: true)
    }
    
    private func dataPublisher(
        for endpoint: Endpoint,
        reloadCache: Bool
        ) -> AnyPublisher<Data, URLError> {
        
        guard let url = URL(string: endpoint.urlString) else {
            return Publishers
                .Fail(outputType: Data.self, failure: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        let urlRequest = URLRequest(
            url: url,
            cachePolicy: reloadCache ? .reloadRevalidatingCacheData : .returnCacheDataElseLoad
        )
        
        return session
            .dataTaskPublisher(for: urlRequest)
            .map { data, _ in data }
            .eraseToAnyPublisher()
    }
}
