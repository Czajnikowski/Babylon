//
//  PostDetailsViewModel.swift
//  ViewModel
//
//  Created by Maciek on 01/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Combine
import View

public final class MockedPostDetailsViewModel {
    public var state: PostDetailsViewState? {
        didSet { sendChange.send() }
    }
    
    public var sendChange = PassthroughSubject<Void, Never>()
    
    public init() {
    }
}

extension MockedPostDetailsViewModel: PostDetailsViewModelRepresenting {
    public func loadData() {
        state = PostDetailsViewState(
            author: "Some Author",
            description: "Some Description",
            numberOfComments: 300
        )
    }
}

extension MockedPostDetailsViewModel: ChangeSending {
}

