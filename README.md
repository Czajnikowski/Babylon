<p align="center">
<img src="https://github.com/Babylonpartners/ios-playbook/raw/master/logo.png">
</p>


Hello babylon
==================================


Thank you for taking your time to consider my demo during the recruitment process for the iOS Developer position at your company. I'd be more than happy to join your impressing team.

# Demo

As a demo project I've chosen [*The babylon demo project*](https://github.com/Babylonpartners/ios-playbook/blob/master/Interview/demo.md#1-the-babylon-demo-project).

### Dependencies

I decided to stick to the native frameworks, so there are no 3rd party depenencies by now. The main frameworks of my choice are:

- `Combine` for reactive programming
- `SwiftUI` for the View layer

So to be able to compile and run the project you should have Xcode 11 beta 3 installed (no Catalina needed).

### Architecture

The responsibilities of the app are split across three separate frameworks and the app target itself:

1. `View` - leaf framework concerned just about the presentation layer.
2. `Networking` - leaf framework concerned about the networking.
3. `ViewModel` - framework depending on both `Networking` and `View` concerned about the bidirectional mapping of data between the `View` and underlying logic and services.
4. `Babylon` app target - main target where dependency injection takes place via the `Coordinator`

There is a subtle difference between *classic* MVVM and my approach. In *classic* MVVM the View layer depends on ViewModel, and in my approach the ViewModel depends on the View.  
Such dependency graph makes `View` a decoupled, leaf framework making it easy to compile, develop and test independently. Thanks to it I've been able to leverage the Playground Driven Development technique to implement and trobuleshoot both view's implementations (see `*.playground` in the project).

### Tests

I've written two, taking `PostListViewModel` under test (see `PostListViewModelTests` or Cmd + U on the `Babylon` scheme).  
I've been trying to incorporate snapshot testing as well (see `snapshot_testing` branch) using `FBSnapshotTestCase` by Uber, but [it doesn't seem to work well with SwiftUI at the moment](https://github.com/uber/ios-snapshot-test-case/issues/97).

### Known issues

- [Eagerly evaluated destinations](https://twitter.com/chriseidhof/status/1144242544680849410)
- [Problem with Alert binding](https://stackoverflow.com/questions/56762294/how-to-bind-presentation-of-swiftui-alert-when-triggered-outside-of-the-view)
- [Unable to bind to animation](https://forums.developer.apple.com/thread/117824)
- Unable to embed multiline Text in vertically scrollable ScrollView

### Requirements checklist

✅ Swift 5.1.  
✅ The information is available offline by leveraging the `URLCache`. The quickest-to-implement solution I can imagine for such a simple requirements.  
✅ Reloading available as a navigation bar item in `PostListView`.  
✅ Have a point of synchronization in `PostDetailsViewModel.loadData()`, I used a `Zip` for that.  
✅ I find the code to be production grade. Not production ready though (uses iOS SDK beta 3).  
✅ It compiles and runs.