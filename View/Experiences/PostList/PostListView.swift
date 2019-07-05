//
//  PostListView.swift
//  View
//
//  Created by Maciek on 24/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

public struct PostRowState: Identifiable, Equatable {
    public let id: Int
    public let title: String
    
    public init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
}

public protocol PostListViewModelRepresenting: ViewBindableObject, AlertMessageControlling {
    var postRowStates: [PostRowState] { get }
    
    func loadData()
}

struct PostListView<ViewModel>: View
where ViewModel: PostListViewModelRepresenting {
    @ObjectBinding private var viewModel: ViewModel
    
    private let listDestinationViewBuilder: ViewForPostWithIdBuilding
    
    var body: some View {
        NavigationView {
            List(viewModel.postRowStates) { postRowState in
                self.listItemView(for: postRowState)
            }
                .navigationBarTitle(
                    Text("Posts".localized(comment: "Navigation bar title"))
                )
                .navigationBarItems(
                    trailing: Button(action: viewModel.loadData) {
                        Image(systemName: "arrow.counterclockwise")
                    }
                )
                .handleAlert(with: viewModel)
        }
            .onAppear(perform: viewModel.loadData)
    }
    
    init(
        viewModel: ViewModel,
        listDestinationViewBuilder: ViewForPostWithIdBuilding
        ) {
        
        self.viewModel = viewModel
        self.listDestinationViewBuilder = listDestinationViewBuilder
    }
    
    private func listItemView(for postRowState: PostRowState) -> AnyView {
        listDestinationViewBuilder.build(forPostWithId: postRowState.id).map { destination in
            NavigationLink(
                destination: destination
            ) {
                Text(postRowState.title)
            }
                .typeErased
        } ?? Text(postRowState.title)
            .typeErased
    }
}
