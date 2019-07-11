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
        PostDetailsView(
            viewModel: MockedPostDetailsViewModel(),
            destinationViewBuilder: NoViewForDependencyBuilder<Int>()
        )
    }
}

public final class PostDetailsViewBuilder<ViewModel>: ViewForDependencyBuilder<Int>
where ViewModel: PostDetailsViewModelRepresenting {
    private let provideViewModelForPostId: (Int) -> ViewModel?
    private let detailsDestinationViewBuilder: ViewForDependencyBuilder<Int>
    
    public init(
        viewModelForPostIdProvider provideViewModelForPostId: @escaping (Int) -> ViewModel?,
        detailsDestinationViewBuilder: ViewForDependencyBuilder<Int>
        ) {
        
        self.provideViewModelForPostId = provideViewModelForPostId
        self.detailsDestinationViewBuilder = detailsDestinationViewBuilder
    }

    override func buildView(for postId: Int) -> AnyView? {
        provideViewModelForPostId(postId)
            .map {
                PostDetailsView(
                    viewModel: $0,
                    destinationViewBuilder: detailsDestinationViewBuilder
                )
            }
            .typeErased
    }
}
