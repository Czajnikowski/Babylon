import PlaygroundSupport
import View

PlaygroundPage.current.liveView = PostListViewBuilder
    .buildMocked()
    .wrappedInHostingController
