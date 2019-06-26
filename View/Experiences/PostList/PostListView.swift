//
//  PostListView.swift
//  View
//
//  Created by Maciek on 24/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Combine
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
    var alertMessage: String? { get set }
    
    func reloadData()
}

struct PostListView<ViewModel>: View
where ViewModel: BindableObject, ViewModel: PostListViewModelRepresenting {
    @ObjectBinding private var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.rowModels) {
                Text($0.title)
            }
                .navigationBarTitle(Text("Posts"))
                .navigationBarItems(
                    trailing: Button(action: viewModel.reloadData) {
                        Image(systemName: "arrow.counterclockwise")
                    }
                )
                .presentation(alertMessageBinding) {
                    Alert(
                        title: Text("Error"),
                        message: Text(viewModel.alertMessage ?? "Unknown error")
                    )
                }
        }
            .onAppear(perform: viewModel.reloadData)
    }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    private var alertMessageBinding: Binding<Bool> {
        return Binding(
            getValue: { self.viewModel.alertMessage != nil },
            setValue: { if !$0 { self.viewModel.alertMessage = nil } }
        )
    }
}
