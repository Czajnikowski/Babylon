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

public protocol PostListViewModelRepresenting: ObservableObject, AlertMessageControlling {
    var postRowStates: [PostRowState] { get }
    
    func loadData()
}

struct PostListView<ViewModel>: View
where ViewModel: PostListViewModelRepresenting {
    @ObservedObject private var viewModel: ViewModel
    
    @State private var isInfoPresented: Bool = false
    
    private let listDestinationViewBuilder: ViewForDependencyBuilder<Int>
    
    var body: some View {
        NavigationView {
            List(viewModel.postRowStates) { postRowState in
                Text(postRowState.title)
                    .wrapped(
                        using: OptionalNavigationLinkWrapper {
                            self.listDestinationViewBuilder.buildView(for: postRowState.id)
                        }
                    )
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
                .actionSheet(isPresented: $isInfoPresented) {
                    ActionSheet(
                        title: Text(
                            """
                            \("Babylon health demo submision by Maciek Czarnik"
                                .localized(comment: "Info section")
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
}
