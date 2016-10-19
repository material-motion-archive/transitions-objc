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

#import "MDMTransitionDirector.h"

/** The delegate protocol used by MDMViewControllerTransition. */
@protocol MDMViewControllerTransitionDelegate <NSObject>

/** Invoked once the transition has reached its conclusion. */
- (void)transitionDidFinish;

@end

/**
 A view controller transition governs the lifecycle of a single UIViewController transition.

 This object is a bridge between MDMTransitionController and the Material Motion Runtime.
 */
@interface MDMViewControllerTransition : NSObject <UIViewControllerAnimatedTransitioning, UIViewControllerInteractiveTransitioning>

/** Initializes a newly allocated view controller transition with a given direction and director. */
- (nonnull instancetype)initWithDirector:(nonnull MDMTransitionDirector *)director;

/** Unavailable. Use initWithDirection:director: instead. */
- (nonnull instancetype)init NS_UNAVAILABLE;

/** The delegate can react to events. */
@property(nonatomic, weak, nullable) id<MDMViewControllerTransitionDelegate> delegate;

@end
