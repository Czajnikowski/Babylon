//
//  PostListView.swift
//  View
//
//  Created by Maciek on 24/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

public struct PostRowModel: Identifiable {
    public let id: Int
    public let title: String
    
    public init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
}

public protocol PostListViewModelRepresenting: class {
    var rowModels: [PostRowModel] { get }
    
    func onAppear()
    func onRefresh()
}

struct PostListView<ViewModel>: View
where ViewModel: BindableObject, ViewModel: PostListViewModelRepresenting {
    @ObjectBinding var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.rowModels) {
                Text($0.title)
            }
                .navigationBarTitle(Text("Posts"))
                .navigationBarItems(
                    trailing: Button(action: viewModel.onRefresh) {
                        Text("Refresh")
                    }
                )
        }
            .onAppear(perform: viewModel.onAppear)
    }
}
