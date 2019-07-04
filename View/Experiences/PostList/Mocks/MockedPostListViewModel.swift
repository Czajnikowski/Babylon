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
    var alertMessage: String? {
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
        alertMessage = "Test message"
        postRowStates.append(PostRowState(id: 1, title: "Yo"))
    }
    
    func consumeAlertMessage() {
        alertMessage = nil
    }
}
