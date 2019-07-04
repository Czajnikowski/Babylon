//
//  PostDetailsViewBuilder.swift
//  View
//
//  Created by Maciek on 02/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

final class PostDetailsViewBuilder<ViewModel>
where ViewModel: PostDetailsViewModelRepresenting {
    private let provideViewModelForPostId: (Int) -> ViewModel
    
    init(viewModelForPostIdProvider provideViewModelForPostId: @escaping (Int) -> ViewModel) {
        self.provideViewModelForPostId = provideViewModelForPostId
    }
}

extension PostDetailsViewBuilder: ViewForPostWithIdBuilding {
    func build(forPostWithId postId: Int) -> AnyView {
        PostDetailsView(viewModel: provideViewModelForPostId(postId))
            .typeErased
    }
}

public final class MockedPostDetailsViewBuilder {
    public static func buildMocked() -> some View {
        PostDetailsView(viewModel: MockedPostDetailsViewModel())
    }
}
