//
//  PostListView.swift
//  View
//
//  Created by Maciek on 24/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

public struct PostRowModel: Identifiable, Equatable {
    public let id: Int
    public let title: String
    
    public init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
}

public protocol PostListViewModelRepresenting: ViewBindableObject {
    var postRowModels: [PostRowModel] { get }
    var error: BabylonError? { get set }
    
    func loadData()
}

struct PostListView<ViewModel>: View
where ViewModel: PostListViewModelRepresenting {
    @ObjectBinding private var viewModel: ViewModel
    
    private let postDetailsViewModelBuilder: ChangePropagatingPostDetailsViewModelBuilder?
    
    var body: some View {
        NavigationView {
            List(viewModel.postRowModels) { postRowModel in
                self.postDetailsViewModelBuilder.map { builder in
                    NavigationLink(
                        destination: PostDetailsView(
                            viewModel: builder.build(forPostWithId: postRowModel.id)
                        )
                    ) {
                        Text(postRowModel.title)
                    }
                }
                if self.postDetailsViewModelBuilder == nil {
                    Text(postRowModel.title)
                }
            }
                .navigationBarTitle(Text("Posts"))
                .navigationBarItems(
                    trailing: Button(action: viewModel.loadData) {
                        Image(systemName: "arrow.counterclockwise")
                    }
                )
                .presentation(alertPresentationBinding) {
                    Alert(
                        title: Text("Error"),
                        message: Text(viewModel.error?.alertMessage ?? "Unknown error")
                    )
                }
        }
            .onAppear(perform: viewModel.loadData)
    }
    
    private var alertPresentationBinding: Binding<Bool> {
        return Binding(
            getValue: { self.viewModel.error != nil },
            setValue: { if !$0 { self.viewModel.error = nil } }
        )
    }
    
    init(viewModel: ViewModel, postDetailsViewModelBuilder: ChangePropagatingPostDetailsViewModelBuilder?) {
        self.viewModel = viewModel
        self.postDetailsViewModelBuilder = postDetailsViewModelBuilder
    }
}
