//
//  PostDetailsViewBuilder.swift
//  View
//
//  Created by Maciek on 02/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

public final class PostDetailsViewBuilder<ViewModel>
where ViewModel: PostDetailsViewModelRepresenting {
    private let provideViewModelForPostId: (Int) -> ViewModel
    
    public init(viewModelForPostIdProvider provideViewModelForPostId: @escaping (Int) -> ViewModel) {
        self.provideViewModelForPostId = provideViewModelForPostId
    }
}

extension PostDetailsViewBuilder: ViewForPostWithIdBuilding {
    public func build(forPostWithId postId: Int) -> AnyView {
        return AnyView(
            PostDetailsView(viewModel: provideViewModelForPostId(postId))
        )
    }
}
