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

#import <Foundation/Foundation.h>

/**
 A transition dismisser is capable of initiating a view controller dismissal transition in reaction
 to gesture recognizer events.
 */
NS_SWIFT_NAME(TransitionDismisser)
@interface MDMTransitionDismisser : NSObject

/** Unavailable. */
- (nonnull instancetype)init NS_UNAVAILABLE;

/** Unavailable. */
+ (nonnull instancetype) new NS_UNAVAILABLE;

#pragma mark Gesture dismissing

/**
 Registers the dismisser as a receiver of gesture recognizer events.

 A dismiss transition will be initiated when this gesture recognizer begins.

 If the gestureRecognizer's delegate is nil, the dismisser will assign itself as the delegate in
 order to allow this gesture recognizer to be recognized simultaneously with other registered
 recognizers.

 All registered gesture recognizers are simultaneously-recognizable by default. To disable this
 behavior use disableSimultaneousRecognitionOfGestureRecognizer:.
 */
- (void)dismissWhenGestureRecognizerBegins:(nonnull UIGestureRecognizer *)gestureRecognizer;

#pragma mark Configuring simultaneous recognition

/**
 Disables simultaneous recognition of a given gesture recognizer.

 The provided gesture recognizer does not need to have been registered with
 dismissWhenGestureRecognizerBegins:
 */
- (void)disableSimultaneousRecognitionOfGestureRecognizer:(nonnull UIGestureRecognizer *)gestureRecognizer;

@end
