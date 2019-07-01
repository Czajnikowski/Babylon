//
//  PostListViewModelBuilder.swift
//  ViewModel
//
//  Created by Maciek on 28/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import View

public final class PostListViewModelBuilder {
    public static func build(
        api: APIProviding
        ) -> some PostListViewModelRepresenting & PostProviding {
        
        return PostListViewModel(api: api)
    }
}

public final class PostDetailsViewModelBuilder {
    public static func build(
        post: PostDTO,
        api: APIProviding
        ) -> ChangeSending & PostDetailsViewModelRepresenting {
        
        return PostDetailsViewModel(post: post, api: api)
    }
}

public protocol PostProviding {
    func providePost(forPostId postId: Int) -> PostDTO
}
