//
//  PostListViewBuilder.swift
//  View
//
//  Created by Maciek on 25/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

public final class MockedPostListViewBuilder {
    private class NoListDestinationViewBuilder: ViewForPostWithIdBuilding {
        fileprivate init() {}
        
        func build(forPostWithId postId: Int) -> AnyView? {
            nil
        }
    }
    
    public static func buildMocked() -> some View {
        PostListView(
            viewModel: MockedPostListViewModel(),
            listDestinationViewBuilder: NoListDestinationViewBuilder()
        )
    }
}

public final class PostListViewBuilder {
    public static func build<ViewModel, DetailsViewModel>(
        viewModel: ViewModel,
        detailsViewModelForPostIdProvider provideDetailsViewModelForPostId: @escaping (Int) -> DetailsViewModel?
        ) -> some View where ViewModel: PostListViewModelRepresenting,
        DetailsViewModel: PostDetailsViewModelRepresenting {
        
        PostListView(
            viewModel: viewModel,
            listDestinationViewBuilder: PostDetailsViewBuilder(
                viewModelForPostIdProvider: provideDetailsViewModelForPostId
            )
        )
    }
}
