import PlaygroundSupport
import UIKit
import View

PlaygroundPage.current.liveView = UINavigationController(
    rootViewController: MockedPostDetailsViewBuilder
        .buildMocked()
        .wrappedInHostingController
)
