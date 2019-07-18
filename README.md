<p align="center">
<img src="https://github.com/Czajnikowski/Babylon/raw/master/logo.png">
</p>

Hello ~~Babylon~~
==================================

~~Thank you for taking the time to consider my demo during the recruitment process for the Remote Senior iOS Developer position at your company. I'd be more than happy to join your impressing team.~~

Initially I prepared the demo as an assignment in the [interview process](https://github.com/Babylonpartners/ios-playbook/blob/master/Interview/README.md) for Babylon Health. I actually passed the demo stage and scored "very well", but the company decided to pause on hiring new remote engineers just a day before my Skype interview. Well 🤷🏼‍♂️

It's a pretty generic demo though. You may find some interesting bits there if you're interested in `SwiftUI`, `Combine`, Playground Driven Development or architecture. I appreciate constructive critique as well 🙂

# Demo

As a demo, I've chosen [*The babylon demo project*](https://github.com/Babylonpartners/ios-playbook/blob/master/Interview/demo.md#1-the-babylon-demo-project).

### Requirements

Xcode 11 Beta 4, no Catalina needed.

### Dependencies

I decided to stick to the native frameworks, so there are no 3rd party dependencies by now. The main frameworks of my choice are:

- `Combine` for reactive programming
- `SwiftUI` for the View layer
- `Foundation` for networking and caching

### Architecture

The responsibilities of the app are split across three separate frameworks and the app target itself:

1. `View` - leaf framework concerned just about the presentation layer.
2. `Networking` - leaf framework concerned about networking.
3. `ViewModel` - framework depending on both `Networking` and `View` concerned about the bidirectional mapping of data between the `View` and underlying logic and services.
4. `Babylon` app target - main target where dependency injection takes place via the `Coordinator`

There is a subtle difference between *classic* MVVM and my approach. In *classic* MVVM the View layer depends on ViewModel and in my approach, the ViewModel depends on the View.  
Such dependency graph makes `View` a decoupled, leaf framework making it easy to compile, develop and test independently. Thanks to it I've been able to leverage the Playground Driven Development technique to implement and troubleshoot both view's implementations (see `*.playground` in the project).  
The frameworks are additionally extracted into separate projects. This makes presumable cross-team development less prone to merge conflicts.

### Tests

I've written two, taking `PostListViewModel` under test (see `PostListViewModelTests` or Cmd + U on the `Babylon` scheme).  
I've been trying to incorporate snapshot testing as well (see `snapshot_testing` branch) using `FBSnapshotTestCase` by Uber, but [it doesn't seem to work well with SwiftUI at the moment](https://github.com/uber/ios-snapshot-test-case/issues/97).

### Known issues

- [Eagerly evaluated destinations](https://twitter.com/chriseidhof/status/1144242544680849410)
- [Problem with Alert binding](https://stackoverflow.com/questions/56762294/how-to-bind-presentation-of-swiftui-alert-when-triggered-outside-of-the-view)
- [Unable to bind to animation](https://forums.developer.apple.com/thread/117824)
- [Unable to embed multiline Text in vertically scrollable ScrollView](https://stackoverflow.com/questions/56593120/how-do-you-create-a-multi-line-text-inside-a-scrollview-in-swiftui)
- ["Reparenting nested renderer host -- preferences may be missing"](https://www.reddit.com/r/swift/comments/c1spxh/reparenting_nested_renderer_host_preferences_may/") while navigating to Details view

### Requirements checklist

✅ Swift 5.1.  
✅ The information is available offline by leveraging the `URLCache`. The quickest-to-implement solution I can imagine.  
✅ Reloading available as a navigation bar item in `PostListView`.  
✅ Have a point of synchronization in `PostDetailsViewModel.loadData()`, I used a `Zip` for that.  
✅ I find the code to be production grade. Not production ready though (uses iOS SDK beta 3).  
✅ It compiles and runs.
