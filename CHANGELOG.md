# release-candidate

 TODO: Enumerate changes.
# 1.0.0

Initial release.

Includes support for customizing UIViewController transitions with a TransitionDirector.

## Source changes

* [Add CatalogByConvention dependency and upgrade Runtime dependency to v5.](https://github.com/material-motion/material-motion-transitions-objc/commit/e6c3fa90f7ca6af86df981126302f517174bbe53) (Jeff Verkoeyen)
* [Update Scheduler references with Runtime.](https://github.com/material-motion/material-motion-transitions-objc/commit/34d599ed6ecff017e90c445973acbc3e6cc94379) (Jeff Verkoeyen)
* [Add TimeWindow APIs.](https://github.com/material-motion/material-motion-transitions-objc/commit/8c83bc29a4d0804466d6a65ffb8ab2a9d1b7082a) (Jeff Verkoeyen)
* [Migrate TransitionDirector to a protocol.](https://github.com/material-motion/material-motion-transitions-objc/commit/71bd0d22beff99a6a1a348cbedc01baa075f9d31) (Jeff Verkoeyen)
* [Add missing MDMTransition.h to the umbrella header.](https://github.com/material-motion/material-motion-transitions-objc/commit/911deecfd12915adca7b7cd0883b6bfbdcc487ca) (Jeff Verkoeyen)
* [Reduce scope of Transition's scheduler object.](https://github.com/material-motion/material-motion-transitions-objc/commit/9fd21b236a1dcfc8e2bf7338abc55b390e57e77f) (Jeff Verkoeyen)
* [Implementing Transition.](https://github.com/material-motion/material-motion-transitions-objc/commit/588e1b93f5746945f8fe82ed4cf7542727f440c1) (Jeff Verkoeyen)
* [Remove interactive transition API implementations.](https://github.com/material-motion/material-motion-transitions-objc/commit/f38cac440592c6cea14cfadb96cedcf03f6e1f56) (Jeff Verkoeyen)
* [Clear the transition controller's transition instance on transition completion.](https://github.com/material-motion/material-motion-transitions-objc/commit/fbc88dcdd5827a505712e82d3f64b0365ea338ef) (Jeff Verkoeyen)
* [Fix unit test build breakage due to API change.](https://github.com/material-motion/material-motion-transitions-objc/commit/db21e1c13b22ab2ae866a03ff3ff3cc2a54b8d68) (Jeff Verkoeyen)
* [Update Runtime dependency to v4 and remove usage of Transaction API.](https://github.com/material-motion/material-motion-transitions-objc/commit/cdd9a6fff8065191350924ef5442cc6489c7793d) (Jeff Verkoeyen)
* [Migrate to fore/back APIs for view controller values and direction.](https://github.com/material-motion/material-motion-transitions-objc/commit/645bfe103416bb49a39cc2432db4a5b313cb822c) (Jeff Verkoeyen)
* [Upgrade pod dependencies, resolve build breakages, and increase warning strictness.](https://github.com/material-motion/material-motion-transitions-objc/commit/655965565174bdcbf006930961092a8c6c7c0fa6) (Jeff Verkoeyen)
* [Revert "Add Objective-C tests in effort to get Travis CI to generate coverage."](https://github.com/material-motion/material-motion-transitions-objc/commit/583f4552e35cde23e0e97a670bb3966ddfb28719) (Jeff Verkoeyen)
* [Add Objective-C tests in effort to get Travis CI to generate coverage.](https://github.com/material-motion/material-motion-transitions-objc/commit/52ddef08595f78b0e15092c9bbfa187937761b35) (Jeff Verkoeyen)
* [Swift API modernization.](https://github.com/material-motion/material-motion-transitions-objc/commit/18dad823ff5ec67acced78fc563fd57f89c7117b) (Jeff Verkoeyen)
* [Add transition director to the umbrella header.](https://github.com/material-motion/material-motion-transitions-objc/commit/a164d6300a90e4e8fcc0f8306f108e57e2ccbbb3) (Jeff Verkoeyen)
* [Xcode 8 beta 4 Swift language changes.](https://github.com/material-motion/material-motion-transitions-objc/commit/9b98bf19b0c6700913372adfe811d8ddade49aa2) (Jeff Verkoeyen)
* [Store from/to view controller in the transition director.](https://github.com/material-motion/material-motion-transitions-objc/commit/103b6db387d1e488d18d1fd357f438c7394bbf87) (Jeff Verkoeyen)
* [Rename left/right APIs to from/to.](https://github.com/material-motion/material-motion-transitions-objc/commit/15361410067ee591fc57b2ddc6e900759ee0438f) (Jeff Verkoeyen)
* [Fix Runtime APIs for swift.](https://github.com/material-motion/material-motion-transitions-objc/commit/2027eeb28a4c7ad1060d980e0313363772628f2b) (Jeff Verkoeyen)
* [Add directorClass to MDMTransitionController.](https://github.com/material-motion/material-motion-transitions-objc/commit/3795cd4bfec8c871d4ee449ab7a2c7947c995102) (Jeff Verkoeyen)
* [Add text linter for source.](https://github.com/material-motion/material-motion-transitions-objc/commit/cbae17a028800c0a32408a849c03899b67ad9b24) (Jeff Verkoeyen)
* [Hook up MDMTransitionController to the MDMViewControllerTransition instance.](https://github.com/material-motion/material-motion-transitions-objc/commit/0aa710960343c332ccee59f3284b24dc6dee69f6) (Jeff Verkoeyen)
* [Make transition director initializer nonnull.](https://github.com/material-motion/material-motion-transitions-objc/commit/49ac1125132311f777deda44360b889902adc943) (Jeff Verkoeyen)
* [Add missing nonnull specifier to transition controller's init method.](https://github.com/material-motion/material-motion-transitions-objc/commit/1c8b091ba36aa5df43154df83ff3b4ff98408ef7) (Jeff Verkoeyen)
* [Add currentDirection and transitionDuration APIs to MDMTransitionDirector.](https://github.com/material-motion/material-motion-transitions-objc/commit/7918b962783d941f418bb40003eb6c7246ff9487) (Jeff Verkoeyen)
* [Implement disableReplicationForElement and createReplica in MDMReplicaController.](https://github.com/material-motion/material-motion-transitions-objc/commit/3013583ebebbc56f51d513bc4528a5b67cc30454) (Jeff Verkoeyen)
* [Add replica controller type.](https://github.com/material-motion/material-motion-transitions-objc/commit/16d2b951eee096eac648e5f30ecb005f4f2c5914) (Jeff Verkoeyen)
* [Add API docs for MDMTransitionController.](https://github.com/material-motion/material-motion-transitions-objc/commit/b062896c09ee6c2daac84753c070e7a72b6dce24) (Jeff Verkoeyen)
* [Add MDMTransitionDirector type.](https://github.com/material-motion/material-motion-transitions-objc/commit/e262561063413ab8e8ca0bbcf1d81b72e740b5ab) (Jeff Verkoeyen)
* [Add scaffolding for MDMTransitionController type.](https://github.com/material-motion/material-motion-transitions-objc/commit/00bc54d49fac7e8ad5268fa3ab8ad3957950dac6) (Jeff Verkoeyen)
* [Add catalog scaffolding. Deleted the unit tests project.](https://github.com/material-motion/material-motion-transitions-objc/commit/1592033daacd3cc616b5c069943988ba8fef7019) (Jeff Verkoeyen)
* [Add scaffolding for transitions unit tests project.](https://github.com/material-motion/material-motion-transitions-objc/commit/7b2a174a576a1e1c5c0284e150f24187fe2539f3) (Jeff Verkoeyen)

## API changes

Auto-generated by running:

    apidiff origin/stable release-candidate objc src/MaterialMotionTransitions.h

## MDMReplicaControllerDelegate

*new* method: `-replicateElement:` in `MDMReplicaControllerDelegate`

*new* protocol: `MDMReplicaControllerDelegate`

## MDMTransition

*new* method: `-init` in `MDMTransition`

*new* property: `runtime` in `MDMTransition`

*new* class: `MDMTransition`

*new* property: `window` in `MDMTransition`

*new* property: `foreViewController` in `MDMTransition`

*new* property: `backViewController` in `MDMTransition`

## MDMTimeWindowSegment

*new* field: `position` in `MDMTimeWindowSegment`

*new* struct: `MDMTimeWindowSegment`

*new* field: `length` in `MDMTimeWindowSegment`

## MDMTransitionDirector

*new* class method: `+transitionDuration` in `MDMTransitionDirector`

*new* method: `-setUp` in `MDMTransitionDirector`

*new* protocol: `MDMTransitionDirector`

*new* method: `-initWithTransition:` in `MDMTransitionDirector`

## MDMTransitionDirectorTransitionDurationDefault

*new* constant: `MDMTransitionDirectorTransitionDurationDefault`

## MDMTimeWindow

*new* property: `duration` in `MDMTimeWindow`

*new* property: `initialDirection` in `MDMTimeWindow`

*new* method: `-initWithInitialDirection:duration:` in `MDMTimeWindow`

*new* method: `-init` in `MDMTimeWindow`

*new* class: `MDMTimeWindow`

*new* property: `position` in `MDMTimeWindow`

*new* property: `currentDirection` in `MDMTimeWindow`

## MDMTransitionController

*new* class: `MDMTransitionController`

*new* method: `-init` in `MDMTransitionController`

*new* property: `directorClass` in `MDMTransitionController`

## MDMTimeWindowSegmentEpsilon

*new* constant: `MDMTimeWindowSegmentEpsilon`

## MDMTimeWindowDirection

*new* typedef: `MDMTimeWindowDirection`

*new* enum value: `MDMTimeWindowDirectionForward` in `MDMTimeWindowDirection`

*new* enum: `MDMTimeWindowDirection`

*new* enum value: `MDMTimeWindowDirectionBackward` in `MDMTimeWindowDirection`

## UIViewController(MaterialMotionTransitions)

*new* category: `UIViewController(MaterialMotionTransitions)`

*new* property: `mdm_transitionController` in `UIViewController(MaterialMotionTransitions)`

## MDMReplicaController

*new* class: `MDMReplicaController`

*new* method: `-disableReplicationForElement:` in `MDMReplicaController`

*new* method: `-replicateElement:` in `MDMReplicaController`

*new* property: `delegate` in `MDMReplicaController`

## Non-source changes

* [Automatic changelog preparation for release.](https://github.com/material-motion/material-motion-transitions-objc/commit/3e43aeee334c8406ea54bda5f550788d1113b73a) (Jeff Verkoeyen)
* [Add missing backticks for code block.](https://github.com/material-motion/material-motion-transitions-objc/commit/c8dfee3c13bd36e35626d105b5c9f066a3c637b5) (Jeff Verkoeyen)
* [Add initial README guides.](https://github.com/material-motion/material-motion-transitions-objc/commit/90e5b4889d5ae827cd59540079488d5fe927554d) (Jeff Verkoeyen)
* [Update runtime dependency to latest develop SHA.](https://github.com/material-motion/material-motion-transitions-objc/commit/6a243bdd751befd068d2ee984a5bedb49818729f) (Jeff Verkoeyen)
* [Update Runtime dependency to latest develop SHA.](https://github.com/material-motion/material-motion-transitions-objc/commit/76fc3f6a309a0821096f0395940618de109f259d) (Jeff Verkoeyen)
* [Update Podfile.lock with latest CocoaPods version.](https://github.com/material-motion/material-motion-transitions-objc/commit/72f839562d7d90d0a11cd3f094004d34622119b1) (Jeff Verkoeyen)
* [Ran yo mm-github.](https://github.com/material-motion/material-motion-transitions-objc/commit/c71e78703f3a058252eb747ea85364205ddbcc58) (Jeff Verkoeyen)
* [Lock Runtime dependency into v3 and update .travis + Podfile.](https://github.com/material-motion/material-motion-transitions-objc/commit/13405d6a3ea23516d2fef2d19e1e6242d1111976) (Jeff Verkoeyen)
* [Add codecov.yml configuration ignoring examples source.](https://github.com/material-motion/material-motion-transitions-objc/commit/20717288a1b4653ff2487088e17a72a1158c40aa) (Jeff Verkoeyen)
* [Xcode 8 GM build fixes.](https://github.com/material-motion/material-motion-transitions-objc/commit/701aba277d34b77baf3e5659147900e7a1125ce9) (Jeff Verkoeyen)
* [Update Xcode project settings with latest recommendations.](https://github.com/material-motion/material-motion-transitions-objc/commit/6364269b71164ddf39857a34f13284cd372bfb67) (Jeff Verkoeyen)
* [Enable coverage generation in the UnitTests target.](https://github.com/material-motion/material-motion-transitions-objc/commit/9a781aa3a3e6db5e16b886535bdb77af4d363970) (Jeff Verkoeyen)
* [Add a simple fade in UIViewController transition driven by a Director.](https://github.com/material-motion/material-motion-transitions-objc/commit/91909055424b6e44182da1b80aff258e99d43921) (Jeff Verkoeyen)
* [Xcode 8 beta 6 build error fixes.](https://github.com/material-motion/material-motion-transitions-objc/commit/45772f52f2fc36f08abefe60a49ecab7ba004af3) (Jeff Verkoeyen)
* [Ran yo mm-github.](https://github.com/material-motion/material-motion-transitions-objc/commit/536206419331a86ef0aa122326bcc2d6c4b6179e) (Jeff Verkoeyen)
* [Ran yo mm-github.](https://github.com/material-motion/material-motion-transitions-objc/commit/bd3fa1edd3757085584c9b14d899ff6fba89718e) (Jeff Verkoeyen)
* [Clone material-arc-tools in travis builds.](https://github.com/material-motion/material-motion-transitions-objc/commit/10f9be6ade6fd7b7f3419d0f906c943a7df15c66) (Jeff Verkoeyen)
* [Remove all git submodules.](https://github.com/material-motion/material-motion-transitions-objc/commit/6f9c8b2ed557f9bacd55a79b25fa250ddd59f451) (Jeff Verkoeyen)
* [Add Core Animation motion family dependency.](https://github.com/material-motion/material-motion-transitions-objc/commit/95cef2542cbbbec63e146c112348c4540883e891) (Jeff Verkoeyen)
* [Add codecov output to .travis.yml.](https://github.com/material-motion/material-motion-transitions-objc/commit/23ba0ff8353774c1d110308cd78c2b4681bf4097) (Jeff Verkoeyen)
* [[automated lsc] Add --trace to arc unit invocation for travis builds.](https://github.com/material-motion/material-motion-transitions-objc/commit/5ef2e85dacddc4ca94be48bb2179e3193d93d147) (Jeff Verkoeyen)
* [Resolve xcodebuild hang caused by uppercase S in "iPhone 6S".](https://github.com/material-motion/material-motion-transitions-objc/commit/6807f35e69b5db548dabac197a87f7d62267f9d2) (Jeff Verkoeyen)
* [Use the https:// url for development cocoapods dependencies.](https://github.com/material-motion/material-motion-transitions-objc/commit/8560bc4cc73bbe428ce5b3ca9e86ed2441dce699) (Jeff Verkoeyen)
* [Add Podfile to .arcunit whitelist.](https://github.com/material-motion/material-motion-transitions-objc/commit/0eee98b17badecfe632853cd6671cb4aaece1585) (Jeff Verkoeyen)
* [Remove core animation family change that snuck in to c540a690cb5fbe94229d42880da38a178afbdbcd.](https://github.com/material-motion/material-motion-transitions-objc/commit/11f16c9429b17e1756fe12bd3e09a532d0bf0d83) (Jeff Verkoeyen)
* [Add Swift 3 Podfile enforcement.](https://github.com/material-motion/material-motion-transitions-objc/commit/c540a690cb5fbe94229d42880da38a178afbdbcd) (Jeff Verkoeyen)
* [Add travis badge to README.](https://github.com/material-motion/material-motion-transitions-objc/commit/0d5b3970fe4c3ef911d8bc46a828779c9742f966) (Jeff Verkoeyen)
* [Run yo mm-github.](https://github.com/material-motion/material-motion-transitions-objc/commit/38a0a3f2d673e21c4ae225c4d2bd04a547736254) (Jeff Verkoeyen)
* [Update arc-xcode-test-engine to v3.0.7.](https://github.com/material-motion/material-motion-transitions-objc/commit/067ae7a482b684621a24ba16f5a071a454aa1b15) (Jeff Verkoeyen)
* [Upgrade xcode project settings to latest recommendations.](https://github.com/material-motion/material-motion-transitions-objc/commit/67abae1a991fe0b419e5b6958ef3f36061456caf) (Jeff Verkoeyen)
* [arc diff now uses the default base ref behavior.](https://github.com/material-motion/material-motion-transitions-objc/commit/9587c632b260d5c72768d464b31bf7064c29db6e) (Jeff Verkoeyen)
* [Update arc-jazzy-linter to v1.1.0.](https://github.com/material-motion/material-motion-transitions-objc/commit/93b4d32301696080262a917f2d7f8d36d0c06595) (Jeff Verkoeyen)
* [Update arc-jazzy-linter to v1.0.2.](https://github.com/material-motion/material-motion-transitions-objc/commit/05f094abf6e543387e0743490bb055d3ae6642bb) (Jeff Verkoeyen)
* [Remove Swift 2.3 language lock. We now use Swift 3.](https://github.com/material-motion/material-motion-transitions-objc/commit/1e1c3913c28b83b9f6a83aa9b6db098d8ea5f5b1) (Jeff Verkoeyen)
* [Update arc-xcode-test-engine to v3.0.6.](https://github.com/material-motion/material-motion-transitions-objc/commit/5e1d68c0350d1e051fe4f528302d2607b76e22e1) (Jeff Verkoeyen)
* [Ran yo mm-github.](https://github.com/material-motion/material-motion-transitions-objc/commit/42bebf4f42aa0407bf7ae8800696c28d3a8cf72d) (Jeff Verkoeyen)
* [Lock in Swift 2.3 in our examples/unit tests.](https://github.com/material-motion/material-motion-transitions-objc/commit/cc807d9cb75565ef819a64eb43510c8b9d3ea94b) (Jeff Verkoeyen)
* [Re-ran yo mm-github.](https://github.com/material-motion/material-motion-transitions-objc/commit/15daebcc9d719cfe9616367d0177ae3ffcaf85d8) (Jeff Verkoeyen)
* [Re-ran yo mm-github on the repo.](https://github.com/material-motion/material-motion-transitions-objc/commit/d03bd44e6a8d9df95255302a55a512b9cdf2efb6) (Jeff Verkoeyen)
* [Add explicit dependency to the runtime from transitions.](https://github.com/material-motion/material-motion-transitions-objc/commit/48cd2c504d8aad573f7c47b06e98e38be785395b) (Jeff Verkoeyen)
* [Update License](https://github.com/material-motion/material-motion-transitions-objc/commit/1a54ad8d92e93a210d365f63df10b0944bed4a8e) (Will Larche)
* [Update to newer version of this text.](https://github.com/material-motion/material-motion-transitions-objc/commit/97f7d9dd7a43498329bd25217569402889e4692a) (Will Larche)
