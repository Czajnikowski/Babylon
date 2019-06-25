//
//  MockedPostListViewModel.swift
//  View
//
//  Created by Maciek on 25/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Combine
import SwiftUI

class MockedPostListViewModel {
    var rowModels = [PostRowModel]() {
        didSet {
            didChange.send(self)
        }
    }
    
    var didChange = PassthroughSubject<MockedPostListViewModel, Never>()
}

extension MockedPostListViewModel: BindableObject {
}

extension MockedPostListViewModel: PostListViewModelRepresenting {
    func reloadData() {
        rowModels.append(PostRowModel(id: 1, title: "Yo"))
    }
}

