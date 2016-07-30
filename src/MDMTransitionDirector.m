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
#import "MDMTransitionDirector+Private.h"

const NSTimeInterval MDMDefaultTransitionDurationForUIKitAnimations = 0.3;

@implementation MDMTransitionDirector

- (nonnull instancetype)initWithInitialDirection:(MDMTransitionDirection)initialDirection
                              fromViewController:(UIViewController *)fromViewController
                                toViewController:(UIViewController *)toViewController {
  self = [super init];
  if (self) {
    _initialDirection = initialDirection;
    _currentDirection = initialDirection;
    _fromViewController = fromViewController;
    _toViewController = toViewController;
  }
  return self;
}

- (void)setUp:(MDMTransaction *)transaction {
  // No-op
}

- (NSTimeInterval)transitionDurationForUIKitAnimations {
  return MDMDefaultTransitionDurationForUIKitAnimations;
}

@end
