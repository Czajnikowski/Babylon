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
    
    @State private var isInfoPresented: Bool = false
    
    private let listDestinationViewBuilder: ViewForDependencyBuilder<Int>
    
    var body: some View {
        NavigationView {
            List(viewModel.postRowStates) { postRowState in
                self.listItemView(for: postRowState)
            }
                .navigationBarTitle(
                    Text("Posts".localized(comment: "Navigation bar title"))
                )
                .navigationBarItems(
                    leading: Button(action: { self.isInfoPresented = true }) {
                        Image(systemName: "info")
                    },
                    trailing: Button(action: viewModel.loadData) {
                        Image(systemName: "arrow.counterclockwise")
                    }
                )
                .alertPresentation(using: viewModel)
                .presentation($isInfoPresented) {
                    return ActionSheet(
                        title: Text(
                            """
                            \("Babylon health demo submision by Maciek Czarnik"
                                .localized(
                                    comment: "Info section"
                                )
                            )
                            @czajnikowski
                            """
                        )
                    )
                }
        }
            .onAppear(perform: viewModel.loadData)
    }
    
    init(
        viewModel: ViewModel,
        listDestinationViewBuilder: ViewForDependencyBuilder<Int>
        ) {
        
        self.viewModel = viewModel
        self.listDestinationViewBuilder = listDestinationViewBuilder
    }
    
    private func listItemView(for postRowState: PostRowState) -> AnyView {
        listDestinationViewBuilder.buildView(for: postRowState.id).map { destination in
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
