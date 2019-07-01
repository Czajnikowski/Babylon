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
    var didChange = PassthroughSubject<MockedPostDetailsViewModel, Never>()
    
    private func sendChange() {
        didChange.send(self)
    }
}

extension MockedPostDetailsViewModel: BindableObject {
}
