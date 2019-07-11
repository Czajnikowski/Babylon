//
//  PostListViewBuilder.swift
//  View
//
//  Created by Maciek on 25/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

public final class MockedPostListViewBuilder {
    public static func buildMocked() -> some View {
        PostListView(
            viewModel: MockedPostListViewModel(),
            listDestinationViewBuilder: NoViewForDependencyBuilder<Int>()
        )
    }
}

public final class PostListViewBuilder<ViewModel>
where ViewModel: PostListViewModelRepresenting {
    private let viewModel: ViewModel
    private let listDestinationViewBuilder: ViewForDependencyBuilder<Int>
    
    public init(
        viewModel: ViewModel,
        listDestinationViewBuilder: ViewForDependencyBuilder<Int>
        ) {
        
        self.viewModel = viewModel
        self.listDestinationViewBuilder = listDestinationViewBuilder
    }
}

extension PostListViewBuilder {
    public func buildView() -> AnyView? {
        PostListView(
            viewModel: viewModel,
            listDestinationViewBuilder: listDestinationViewBuilder
        )
            .typeErased
    }
}
