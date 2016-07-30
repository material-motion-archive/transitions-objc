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

@import MaterialMotionRuntime;

/** The default duration of a Material Motion view controller transition in seconds. */
extern const NSTimeInterval MDMDefaultTransitionDurationForUIKitAnimations;

/** The possible directions of a view controller transition. */
typedef NS_ENUM(NSUInteger, MDMTransitionDirection) {
  /** The transition is being presented/pushed. */
  MDMTransitionDirectionPresent,

  /** The transition is being dismissed/popped. */
  MDMTransitionDirectionDismiss,
};

/**
 A transition director is responsible for describing the motion that will occur during a
 UIViewController transition.

 This object is intended to be subclassed.
 */
@interface MDMTransitionDirector : NSObject

/** Unavailable. Use MDMTransitionController instead. */
- (nonnull instancetype)init NS_UNAVAILABLE;

#pragma mark Transition direction

/** The initial direction of this transition. */
@property(nonatomic, assign, readonly) MDMTransitionDirection initialDirection;

/** The current direction of this transition. */
@property(nonatomic, assign, readonly) MDMTransitionDirection currentDirection;

#pragma mark Affecting corresponding UIKit animations

/**
 The desired duration of corresponding UIKit animations for this transition in seconds.

 Default: MDMDefaultTransitionDurationForUIKitAnimations
 */
- (NSTimeInterval)transitionDurationForUIKitAnimations;

#pragma mark Set up phase

/**
 Invoked on initiation of a view controller transition.

 This method should be overwritten by the subclass.

 @param transaction All motion added to this transaction instance will be committed to the
                    transition's runtime.
 */
- (void)setUp:(nonnull MDMTransaction *)transaction;

@end
