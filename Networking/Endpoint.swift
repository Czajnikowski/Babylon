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
    user(id: Int)
    
    var urlString: String {
        switch self {
        case .posts:
            return "https://jsonplaceholder.typicode.com/posts"
        case let .user(id):
            return "https://jsonplaceholder.typicode.com/users/\(id)"
        }
    }
}
