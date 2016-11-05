# Material Motion Transitions for Apple Devices

[![Build Status](https://travis-ci.org/material-motion/material-motion-transitions-objc.svg?branch=develop)](https://travis-ci.org/material-motion/material-motion-transitions-objc)
[![codecov](https://codecov.io/gh/material-motion/material-motion-transitions-objc/branch/develop/graph/badge.svg)](https://codecov.io/gh/material-motion/material-motion-transitions-objc)

## Supported languages

- Swift 3
- Objective-C

## Features

This library makes it possible to create UIViewController transitions using the Material Motion
runtime.

## Installation

### Installation with CocoaPods

> CocoaPods is a dependency manager for Objective-C and Swift libraries. CocoaPods automates the
> process of using third-party libraries in your projects. See
> [the Getting Started guide](https://guides.cocoapods.org/using/getting-started.html) for more
> information. You can install it with the following command:
>
>     gem install cocoapods

Add `MaterialMotionTransitions` to your `Podfile`:

    pod 'MaterialMotionTransitions'

Then run the following command:

    pod install

### Usage

Import the framework:

    @import MaterialMotionTransitions;

You will now have access to all of the APIs.

## Example apps/unit tests

Check out a local copy of the repo to access the Catalog application by running the following
commands:

    git clone https://github.com/material-motion/material-motion-transitions-objc.git
    cd material-motion-transitions-objc
    pod install
    open MaterialMotionTransitions.xcworkspace

# Guides

1. [Architecture](#architecture)
2. [How to create a transition director](#how-to-create-a-transition-director)
3. [How to use a director for a view controller transition](#how-to-use-a-director-for-a-view-controller-transition)

## Architecture

The core aspects of this library consist of the following:

- The TransitionDirector protocol
- The TransitionController object

An object conforming to TransitionDirector is able to describe the plans that should occur during
a UIViewController transition.

TransitionController is what allows you to decide which TransitionDirector should govern a
particular transition.

## How to create a transition director

Transition directors govern both the presentation and dismissal of a given view controller. An
instance of a director is created each time a transition is initiated and thrown away upon the
transition's completion.

### Step 1: Create a new class that conforms to TransitionDirector

Be sure to store the provided MDMTransition object.

Code snippets:

***In Objective-C:***

```objc
@interface <# DirectorName #>TransitionDirector : NSObject <MDMTransitionDirector>
@end

@interface <# DirectorName #>TransitionDirector ()
@property(nonatomic, strong) MDMTransition *transition;
@end

@implementation <# DirectorName #>TransitionDirector

- (instancetype)initWithTransition:(MDMTransition *)transition {
  self = [super init];
  if (self) {
    _transition = transition;
  }
  return self;
}

- (void)setUp {
}

@end
```

***In Swift:***

```swift

class <# DirectorName #>TransitionDirector: NSObject, TransitionDirector {

  let transition: Transition
  required init(transition: Transition) {
    self.transition = transition
  }

  func setUp() {
  }
}
```

### Step 2: Register motion in setUp

Register plans using the transition object's runtime.

Code snippets:

***In Objective-C:***

```objc
- (void)setUp {
  [self.transition.runtime addPlan:<#(nonnull NSObject<MDMPlan> *)#> to:<#(nonnull id)#>];
}
```

***In Swift:***
func setUp() {
  transition.runtime.addPlan(<#T##plan: Plan##Plan#>, to: <#T##Any#>)
}
```

### How to use a director for a view controller transition

Every view controller has an associated `mdm_transitionController` instance. Set a
TransitionDirector class type on the `directorClass` property. When you present the view controller,
an instance of your TransitionDirector class will be created and its `setUp` method will be invoked.

Code snippets:

***In Objective-C:***

```objc
<#(nonnull UIViewController *)#>.mdm_transitionController.directorClass = [<# TransitionDirector #>TransitionDirector class];
[self presentViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#> completion:<#^(void)completion#>];
```

***In Swift:***

```swift
<# UIViewController instance #>.mdm_transitionController.directorClass = <# TransitionDirector #>TransitionDirector.self
present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>)
```

## Contributing

We welcome contributions!

Check out our [upcoming milestones](https://github.com/material-motion/material-motion-transitions-objc/milestones).

Learn more about [our team](https://material-motion.gitbooks.io/material-motion-team/content/),
[our community](https://material-motion.gitbooks.io/material-motion-team/content/community/), and
our [contributor essentials](https://material-motion.gitbooks.io/material-motion-team/content/essentials/).

## License

Licensed under the Apache 2.0 license. See LICENSE for details.
