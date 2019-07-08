import PlaygroundSupport
import View

PlaygroundPage.current.liveView = MockedPostListViewBuilder
    .buildMocked()
    .wrappedInHostingController
