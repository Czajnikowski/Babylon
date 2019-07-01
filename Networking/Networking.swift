//
//  Networking.swift
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
        return dataPublisher(for: .posts)
    }
    
    private func dataPublisher(
        for endpoint: Endpoint,
        reloadCache: Bool = true
        ) -> AnyPublisher<Data, URLError> {
        
        guard let url = URL(string: endpoint.urlString) else {
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

extension URLRequest {
    static func urlRequest(for url: URL, reloadCache: Bool = true) -> URLRequest {
        return URLRequest(
            url: url,
            cachePolicy: reloadCache ? .reloadRevalidatingCacheData : .returnCacheDataElseLoad
        )
    }
}
