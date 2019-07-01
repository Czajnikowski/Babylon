//
//  PostDetailsExperienceBuilder.swift
//  View
//
//  Created by Maciek on 25/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

public final class PostDetailsExperienceBuilder {
    public static func buildMockedViewController() -> UIViewController {
        return UIHostingController(
            rootView: PostDetailsView(
                viewModel: ChangePropagatingPostDetailsViewModelBuilder { _ in MockedPostDetailsViewModel() }.build(forPostWithId: 0)
            )
        )
    }
}
