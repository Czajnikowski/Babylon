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
    
    public init(
        author: String,
        description: String,
        numberOfComments: Int
        ) {
        
        self.author = author
        self.description = description
        self.numberOfComments = numberOfComments
    }
}

public protocol PostDetailsViewModelRepresenting {
    var state: PostDetailsViewState? { get }
    
    func loadData()
}

struct PostDetailsView<ViewModel>: View
where ViewModel: BindableObject, ViewModel: PostDetailsViewModelRepresenting {
    @ObjectBinding private var viewModel: ViewModel
    
    var body: some View {
        viewModel.state.map { state in
            VStack(alignment: .leading, spacing: 8) {
                Text("Description:")
                    .font(.headline)
                Text("\(state.description)")
                    .lineLimit(nil)
                    .font(.body)
                
                Text("Number of comments:")
                    .font(.headline)
                Text("\(state.numberOfComments)")
                    .font(.subheadline)
                
                GeometryReader { geometry in
                    Spacer()
                        .frame(width: geometry.size.width)
                }
            }
                .padding(16)
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
