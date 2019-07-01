//
//  PostDetailsView.swift
//  View
//
//  Created by Maciek on 24/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

public struct PostDetailsViewState {
    let author: String
    let description: String
    let numberOfComments: Int
}

protocol PostDetailsViewModelRepresenting: class {
    var state: PostDetailsViewState? { get }
    
    func loadData()
}

struct PostDetailsView<ViewModel>: View
where ViewModel: BindableObject, ViewModel: PostDetailsViewModelRepresenting {
    @ObjectBinding private var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            viewModel.state.map { state in
                Group {
                    Text("Description: \(state.description)")
                        .lineLimit(nil)
                    Text("Number of comments: \(state.numberOfComments)")
                }
            }
        }
            .navigationBarTitle(
                Text((viewModel.state?.author).map { "by: \($0)" } ?? "Loading...")
            )
            .onAppear(perform: viewModel.loadData)
    }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}
