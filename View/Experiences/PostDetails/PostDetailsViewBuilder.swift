//
//  PostDetailsViewBuilder.swift
//  View
//
//  Created by Maciek on 02/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

public final class MockedPostDetailsViewBuilder {
    public static func buildMocked() -> some View {
        PostDetailsView(viewModel: MockedPostDetailsViewModel())
    }
}

public final class PostDetailsViewBuilder<ViewModel>: ViewForDependencyBuilder<Int>
where ViewModel: PostDetailsViewModelRepresenting {
    private let provideViewModelForPostId: (Int) -> ViewModel?
    
    public init(viewModelForPostIdProvider provideViewModelForPostId: @escaping (Int) -> ViewModel?) {
        self.provideViewModelForPostId = provideViewModelForPostId
    }

    override func buildView(for postId: Int) -> AnyView? {
        provideViewModelForPostId(postId)
            .map { PostDetailsView(viewModel: $0) }
            .typeErased
    }
}
