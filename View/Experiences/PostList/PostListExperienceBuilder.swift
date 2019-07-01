//
//  PostListExperienceBuilder.swift
//  View
//
//  Created by Maciek on 25/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

public typealias PostDetailsViewModelForPostIdProvider = (Int) -> ChangeSending & PostDetailsViewModelRepresenting

public final class PostListExperienceBuilder {
    public static func buildMockedViewController() -> UIViewController {
        return buildViewController(viewModel: MockedPostListViewModel())
    }
    
    public static func buildViewController<ViewModel>(
        viewModel: ViewModel,
        postDetailsViewModelProvider: Optional<PostDetailsViewModelForPostIdProvider> = nil
        ) -> UIViewController where ViewModel: PostListViewModelRepresenting {
        
        return UIHostingController(
            rootView: PostListView(
                viewModel: viewModel,
                postDetailsViewModelBuilder: postDetailsViewModelProvider.map(ChangePropagatingPostDetailsViewModelBuilder.init)
            )
        )
    }
}
