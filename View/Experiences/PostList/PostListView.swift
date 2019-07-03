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

public protocol PostListViewModelRepresenting: ViewBindableObject, AlertMessageControlling {
    var postRowModels: [PostRowModel] { get }
    
    func loadData()
}

struct PostListView<ViewModel>: View
where ViewModel: PostListViewModelRepresenting {
    @ObjectBinding private var viewModel: ViewModel
    
    private let listDestinationViewBuilder: ViewForPostWithIdBuilding?
    
    var body: some View {
        NavigationView {
            List(viewModel.postRowModels) { postRowModel in
                self.listItemView(for: postRowModel)
            }
                .navigationBarTitle(Text("Posts"))
                .navigationBarItems(
                    trailing: Button(action: viewModel.loadData) {
                        Image(systemName: "arrow.counterclockwise")
                    }
                )
                .handleAlert(with: viewModel)
        }
            .onAppear(perform: viewModel.loadData)
    }
    
    init(viewModel: ViewModel, listDestinationViewBuilder: ViewForPostWithIdBuilding?) {
        self.viewModel = viewModel
        self.listDestinationViewBuilder = listDestinationViewBuilder
    }
    
    private func listItemView(for postRowModel: PostRowModel) -> AnyView {
       return listDestinationViewBuilder.map { builder in
            AnyView(
                NavigationLink(
                    destination: builder.build(forPostWithId: postRowModel.id)
                ) {
                    Text(postRowModel.title)
                }
            )
        } ?? AnyView(Text(postRowModel.title))
    }
}
