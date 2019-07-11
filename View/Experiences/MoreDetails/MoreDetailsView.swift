//
//  MoreDetailsView.swift
//  View
//
//  Created by Maciek on 10/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

public protocol MoreDetailsViewModelRepresenting: ViewBindableObject {
    var moreDetails: String { get }
}

struct MoreDetailsView<ViewModel>: View
where ViewModel: MoreDetailsViewModelRepresenting {
    @ObjectBinding private var viewModel: ViewModel
    
    var body: some View {
        Text(viewModel.moreDetails)
    }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}
