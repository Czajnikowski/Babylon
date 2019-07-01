//
//  Endpoint.swift
//  Networking
//
//  Created by Maciek on 01/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

enum Endpoint {
    case
    posts
    
    var urlString: String {
        return "https://jsonplaceholder.typicode.com/posts"
    }
}
