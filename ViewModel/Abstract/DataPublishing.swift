//
//  APIProviding.swift
//  ViewModel
//
//  Created by Maciek on 28/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Combine

public protocol PostsDataPublishing {
    func postsDataPublisher() -> AnyPublisher<Data, URLError>
}

public protocol UserDataPublishing {
    func userDataPublisher(forUserWithId userId: Int) -> AnyPublisher<Data, URLError>
}

public protocol CommentDataPublishing {
    func commentDataPublisher(forPostWithId postId: Int) -> AnyPublisher<Data, URLError>
}
