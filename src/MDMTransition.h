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

/** A Transition object represents the essential state for a UIViewController transition. */
NS_SWIFT_NAME(Transition)
@interface MDMTransition : NSObject

/** Unavailable. Transition objects can only be created by a transition controller. */
- (nonnull instancetype)init NS_UNAVAILABLE;

#pragma mark Scheduler

/** The runtime for this transition. */
@property(nonatomic, strong, nonnull, readonly) NSObject<MDMRuntimeFeatures> *runtime;

#pragma mark Time window

/** The time window for this transition. */
@property(nonatomic, strong, nonnull, readonly) MDMTimeWindow *window;

#pragma mark Transition sides

/**
 The back view controller for this transition.

 This is the destination when the transition's direction is backward.
 */
@property(nonatomic, strong, nonnull, readonly) UIViewController *backViewController;

/**
 The fore view controller for this transition.

 This is the destination when the transition's direction is forward.
 */
@property(nonatomic, strong, nonnull, readonly) UIViewController *foreViewController;

@end
