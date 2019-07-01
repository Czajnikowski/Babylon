//
//  ChangePropagatingPostDetailsViewModelBuilder.swift
//  View
//
//  Created by Maciek on 01/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

class ChangePropagatingPostDetailsViewModelBuilder {
    private let provideViewModelForPostWithId: PostDetailsViewModelForPostIdProvider
    
    init(_ provideViewModelForPostWithId: @escaping PostDetailsViewModelForPostIdProvider) {
        self.provideViewModelForPostWithId = provideViewModelForPostWithId
    }

    func build(forPostWithId postId: Int) -> some BindableObject & PostDetailsViewModelRepresenting {
        return ChangePropagatingPostDetailsViewModel(viewModel: provideViewModelForPostWithId(postId))
    }
}
