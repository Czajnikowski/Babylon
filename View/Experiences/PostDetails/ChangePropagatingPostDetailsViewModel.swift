//
//  ChangePropagatingPostDetailsViewModel.swift
//  View
//
//  Created by Maciek on 01/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Combine
import SwiftUI

class ChangePropagatingPostDetailsViewModel: BindableObject {
    var didChange = PassthroughSubject<PostDetailsViewState?, Never>()
    
    private var changePropagation: Cancellable?
    
    private let viewModel: PostDetailsViewModelRepresenting & ChangeSending
    
    init(viewModel: PostDetailsViewModelRepresenting & ChangeSending) {
        self.viewModel = viewModel
        
        changePropagation = viewModel.sendChange.sink { [weak self] in
            self?.didChange.send(viewModel.state)
        }
    }
    
    deinit {
        changePropagation?.cancel()
    }
}

extension ChangePropagatingPostDetailsViewModel: PostDetailsViewModelRepresenting {
    var state: PostDetailsViewState? {
        return viewModel.state
    }
    
    func loadData() {
        viewModel.loadData()
    }
}
