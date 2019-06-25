//
//  PostListExperienceBuilder.swift
//  View
//
//  Created by Maciek on 25/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

public final class PostListExperienceBuilder {
    public static func buildMockedViewController() -> UIViewController {
        return buildViewController(viewModel: MockedPostListViewModel())
    }
    
    public static func buildViewController<ViewModel>(viewModel: ViewModel) -> UIViewController
    where ViewModel: BindableObject, ViewModel: PostListViewModelRepresenting {
        return UIHostingController(rootView: PostListView(viewModel: viewModel))
    }
}
