/*
 Copyright 2016-present The Material Motion Authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <MaterialMotionRuntime/MaterialMotionRuntime.h>
#import <UIKit/UIKit.h>

/**
 The default duration used for a transition if the director does not implement +transitionDuration.
 */
extern const NSTimeInterval MDMTransitionDirectorTransitionDurationDefault;

@class MDMTransition;
@class MDMTransitionDismisser;

/**
 A transition director is responsible for describing the motion that will occur during a
 UIViewController transition.

 This object is intended to be subclassed.
 */
NS_SWIFT_NAME(TransitionDirector)
@protocol MDMTransitionDirector <NSObject>

#pragma mark Transition duration

@optional

/** Invoked on initiation of a view controller transition. */
- (void)willBeginTransition:(nonnull MDMTransition *)transition
    NS_SWIFT_NAME(willBeginTransition(_:));

/** The desired duration to be communicated to UIKit. */
+ (NSTimeInterval)transitionDuration;

// clang-format off

/** Initializes a director with a Transition instance. */
- (nonnull instancetype)initWithTransition:(nonnull MDMTransition *)transition
__deprecated_msg("Implement willBeginTransition: instead. Deprecated in #nextrelease#.");

#pragma mark Set up phase

/**
 Invoked on initiation of a view controller transition.

 This method should be overwritten by the subclass.

 @param transaction All motion added to this transaction instance will be committed to the
 transition's runtime.
 */
- (void)setUp
__deprecated_msg("Implement willBeginTransition: instead. Deprecated in #nextrelease#.");

@end

/**
 A self-dismissing transition director is capable of registering gesture recognizers on the fore
 view controller and associating them with a dismisser instance.

 For example:

     let tap = UITapGestureRecognizer()
     foreViewController.view.addGestureRecognizer(tap)
     dismisser.dismiss(whenGestureRecognizerBegins: tap)
 */
NS_SWIFT_NAME(SelfDismissingTransitionDirector)
@protocol MDMSelfDismissingTransitionDirector <MDMTransitionDirector>

/**
 Invoked when a view controller is presented with this director class.

 Use the provided dismisser to associate any gesture recognizers that should initiate a dismissal.

 Each gesture recognizer associated with the dismisser will be provided to the director if it
 conforms to the InteractiveTransitionDirector protocol.
 */
+ (void)willPresentForeViewController:(nonnull UIViewController *)foreViewController
                            dismisser:(nonnull MDMTransitionDismisser *)dismisser;

@end

/**
 An interactive transition director receives pre-registered gesture recognizers that can affect the
 state of the transition.
 */
NS_SWIFT_NAME(InteractiveTransitionDirector)
@protocol MDMInteractiveTransitionDirector <MDMTransitionDirector>

/**
 Invoked once for each gesture recognizer that has been provided to the transition.

 Invoked after setUp.
 */
- (void)addGestureRecognizer:(nonnull UIGestureRecognizer *)gestureRecognizer;

@end

// clang-format on
