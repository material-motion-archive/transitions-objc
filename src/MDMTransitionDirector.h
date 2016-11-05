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

/**
 A transition director is responsible for describing the motion that will occur during a
 UIViewController transition.

 This object is intended to be subclassed.
 */
NS_SWIFT_NAME(TransitionDirector)
@protocol MDMTransitionDirector <NSObject>

/** Initializes a director with a Transition instance. */
- (nonnull instancetype)initWithTransition:(nonnull MDMTransition *)transition;

#pragma mark Set up phase

/**
 Invoked on initiation of a view controller transition.

 This method should be overwritten by the subclass.

 @param transaction All motion added to this transaction instance will be committed to the
 transition's runtime.
 */
- (void)setUp;

#pragma mark Transition duration

@optional

/** The desired duration to be communicated to UIKit. */
+ (NSTimeInterval)transitionDuration;

@end
