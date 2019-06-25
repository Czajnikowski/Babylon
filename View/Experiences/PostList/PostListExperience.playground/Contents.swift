import Combine
import PlaygroundSupport
import View

class PostListViewModel {
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
        rowModels.append(PostRowModel(id: 1, title: "Yo"))
    }
}

PlaygroundPage.current.liveView = PostListExperienceBuilder.buildViewController(viewModel: PostListViewModel())
