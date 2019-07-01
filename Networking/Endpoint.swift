//
//  Endpoint.swift
//  Networking
//
//  Created by Maciek on 01/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

enum Endpoint {
    case
    posts,
    user(userId: Int),
    comment(postId: Int)
    
    var url: URL? {
        return urlComponents.url
    }
    
    private var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "jsonplaceholder.typicode.com"
        
        switch self {
        case .posts:
            urlComponents.path = "/posts"
        case let .user(userId):
            urlComponents.path = "/users/\(userId)"
        case .comment(let postId):
            urlComponents.path = "/comments"
            urlComponents.queryItems = [
                URLQueryItem(name: "postId", value: "\(postId)")
            ]
        }
        
        return urlComponents
    }
}
