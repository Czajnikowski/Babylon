//
//  MockedPostDetailsViewModel.swift
//  View
//
//  Created by Maciek on 25/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Combine
import SwiftUI

final class MockedPostDetailsViewModel {
    var state: PostDetailsViewState? {
        willSet { willChange.send(self) }
    }
    
    var localizedAlertMessage: String? {
        willSet { willChange.send(self) }
    }
    
    var willChange = PassthroughSubject<MockedPostDetailsViewModel, Never>()
}

extension MockedPostDetailsViewModel: PostDetailsViewModelRepresenting {
    func loadData() {
        state = PostDetailsViewState(
            author: "Some Author",
            description: "Some Description",
            numberOfComments: 30
        )
    }
    
    func consumeAlertMessage() {
        localizedAlertMessage = nil
    }
}

extension MockedPostDetailsViewModel: ObservableObject {
}
