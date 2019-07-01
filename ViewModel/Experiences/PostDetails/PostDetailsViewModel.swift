//
//  PostDetailsViewModel.swift
//  ViewModel
//
//  Created by Maciek on 01/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Combine
import View

final class MockedPostDetailsViewModel {
var state: PostDetailsViewState? {
        didSet { sendChange.send() }
    }
    
    var sendChange = PassthroughSubject<Void, Never>()
}

extension MockedPostDetailsViewModel: PostDetailsViewModelRepresenting {
    func loadData() {
        state = PostDetailsViewState(
            author: "Some Author",
            description: "Some Description",
            numberOfComments: 300
        )
    }
}

extension MockedPostDetailsViewModel: ChangeSending {
}
