//
//  PostListViewModel.swift
//  Controller
//
//  Created by Maciek on 24/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Combine
import View

final class PostListViewModel {
    var alertMessage: String? {
        didSet { sendChange() }
    }
    
    var rowModels = [PostRowModel]() {
        didSet { sendChange() }
    }
    
    var didChange = PassthroughSubject<PostListViewModel, Never>()
    
    private var subscriber: Cancellable?
    
    deinit {
        subscriber?.cancel()
    }
    
    private func sendChange() {
        didChange.send(self)
    }
}

extension PostListViewModel: ChangeReporting {
}

extension PostListViewModel: PostListViewModelRepresenting {
    func reloadData() {
        subscriber?.cancel()

        let request = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
        subscriber = URLSession.shared.dataTaskPublisher(for: request)
            .map { data, _ in data }
            .replaceError(with: Data())
            .decode(type: [PostDTO].self, decoder: JSONDecoder())
            .map { $0.map(PostRowModel.init) }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .finished:
                        print("finished!")
                    case let .failure(error):
                        self?.alertMessage = "\(error)"
                    }
                },
                receiveValue: { [weak self] in self?.rowModels = $0 }
        )
    }
}
