//
//  PostProviding.swift
//  ViewModel
//
//  Created by Maciek on 28/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

public protocol PostProviding {
    func providePost(forPostId postId: Int) -> PostDTO
}
