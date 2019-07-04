//
//  URLRequest+reloadCache.swift
//  Networking
//
//  Created by Maciek on 03/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

extension URLRequest {
    static func urlRequest(for url: URL, reloadCache: Bool = true) -> URLRequest {
        URLRequest(
            url: url,
            cachePolicy: reloadCache ? .reloadRevalidatingCacheData : .returnCacheDataElseLoad
        )
    }
}
