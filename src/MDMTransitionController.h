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

#import <UIKit/UIKit.h>

@class MDMTransitionController;
@class MDMTransitionDismisser;

/** Material Motion Transition extensions for UIViewController */
@interface UIViewController (MaterialMotionTransitions)

/**
 A transition controller may be used to implement custom transitions.

 The transition controller is lazily created upon access. If the view controller's
 transitioningDelegate is nil when the controller is created, then the controller will also be set
 to the transitioningDelegate property.
 */
@property(nonatomic, strong, readonly, nonnull) MDMTransitionController *mdm_transitionController;

@end

/**
 An MDMTransitionController is the bridging object between UIKit's view controller transitioning
 APIs and Material Motion transitions.

 This class is not meant to be instantiated directly.
 */
NS_SWIFT_NAME(TransitionController)
@interface MDMTransitionController : NSObject <UIViewControllerTransitioningDelegate>

/** Unavailable. Use viewController.mdm_transitionController instead. */
- (nonnull instancetype)init NS_UNAVAILABLE;

#pragma mark Dismisser

/** Returns the dismisser instance for the associated view controller. */
@property(nonatomic, strong, nonnull, readonly) MDMTransitionDismisser *dismisser;

#pragma mark Configuring directors

/**
 An instance of the directorClass will be created to describe the motion for this transition
 controller's transitions.

 If no directorClass is provided then a default UIKit transition will be used.

 Must be a subclass of MDMTransitionDirector.
 */
@property(nonatomic, assign, nullable) Class directorClass;

@end
