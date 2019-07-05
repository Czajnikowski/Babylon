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
        didSet { sendChange() }
    }
    
    var postRowStates = [PostRowState]() {
        didSet { sendChange() }
    }
    
    var didChange = PassthroughSubject<MockedPostListViewModel, Never>()
    
    private func sendChange() {
        didChange.send(self)
    }
}

extension MockedPostListViewModel: BindableObject {
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
