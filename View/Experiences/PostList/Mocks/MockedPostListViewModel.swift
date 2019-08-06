//
//  MockedPostListViewModel.swift
//  View
//
//  Created by Maciek on 25/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Combine
import SwiftUI

final class MockedPostListViewModel {
    var localizedAlertMessage: String? {
        willSet { sendChange() }
    }
    
    var postRowStates = [PostRowState]() {
        willSet { sendChange() }
    }
    
    var willChange = PassthroughSubject<MockedPostListViewModel, Never>()
    
    private func sendChange() {
        willChange.send(self)
    }
}

extension MockedPostListViewModel: ObservableObject {
}

extension MockedPostListViewModel: PostListViewModelRepresenting {
    func loadData() {
        localizedAlertMessage = "Test message"
        postRowStates.append(PostRowState(id: 1, title: "Yo"))
    }
    
    func consumeAlertMessage() {
        localizedAlertMessage = nil
    }
}
