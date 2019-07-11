//
//  MoreDetailsViewBuilder.swift
//  View
//
//  Created by Maciek on 10/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

public final class MoreDetailsViewBuilder<ViewModel>: ViewForDependencyBuilder<Int>
where ViewModel: MoreDetailsViewModelRepresenting {
    private let provideViewModelForSomeInt: (Int) -> ViewModel?
    
    public init(
        viewModelForSomeIntProvider provideViewModelForSomeInt: @escaping (Int) -> ViewModel?
        ) {
        
        self.provideViewModelForSomeInt = provideViewModelForSomeInt
    }

    override func buildView(for someInt: Int) -> AnyView? {
        return MoreDetailsView(
            viewModel: provideViewModelForSomeInt(someInt)!
        )
            .typeErased
    }
}
