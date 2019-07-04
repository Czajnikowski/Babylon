//
//  PostListViewBuilder.swift
//  View
//
//  Created by Maciek on 25/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

public final class PostListViewBuilder {
    public static func buildMocked() -> some View {
        PostListView(viewModel: MockedPostListViewModel())
    }
    
    public static func build<ViewModel, DetailsViewModel>(
        viewModel: ViewModel,
        detailsViewModelForPostIdProvider provideDetailsViewModelForPostId: ((Int) -> DetailsViewModel)? = nil
        ) -> some View where ViewModel: PostListViewModelRepresenting,
        DetailsViewModel: PostDetailsViewModelRepresenting {
        
        PostListView(
            viewModel: viewModel,
            listDestinationViewBuilder: provideDetailsViewModelForPostId
                .map(PostDetailsViewBuilder.init)
        )
    }
}
