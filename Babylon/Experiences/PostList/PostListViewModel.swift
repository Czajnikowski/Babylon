//
//  PostListViewModel.swift
//  Controller
//
//  Created by Maciek on 24/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Combine
import View

class PostListViewModel {
    private var subscriber: AnyCancellable?
    
    var rowModels = [PostRowModel]() {
        didSet {
            didChange.send(self)
        }
    }
    
    var didChange = PassthroughSubject<PostListViewModel, Never>()
}

extension PostListViewModel: ChangeReporting {
}

extension PostListViewModel: PostListViewModelRepresenting {
    func onRefresh() {
        reloadData()
    }
    
    func onAppear() {
        reloadData()
    }
    
    private func reloadData() {
        subscriber?.cancel()
        
        let request = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
        subscriber = URLSession.shared.dataTaskPublisher(for: request)
            .map { data, _ in data }
            .replaceError(with: Data())
            .decode(type: [PostDTO].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .map { $0.map(PostRowModel.init) }
            .receive(on: DispatchQueue.main)
            .assign(to: \.rowModels, on: self)
    }
}
