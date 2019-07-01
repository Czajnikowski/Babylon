//
//  APIProviding.swift
//  ViewModel
//
//  Created by Maciek on 28/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Combine

public protocol APIProviding {
    func postsDataPublisher() -> AnyPublisher<Data, URLError>
    func userDataPublisher(forUserWithId userId: Int) -> AnyPublisher<Data, URLError>
}
