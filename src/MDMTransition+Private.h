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

#import "MDMTransition.h"

@protocol MDMTransitionDelegate <NSObject>

- (void)transitionDidComplete:(nonnull MDMTransition *)transition;

@end

@interface MDMTransition () <UIViewControllerAnimatedTransitioning>

- (nonnull instancetype)initWithDirectorClass:(nonnull Class)directorClass
                                    direction:(MDMTimeWindowDirection)direction
                           backViewController:(nonnull UIViewController *)backViewController
                           foreViewController:(nonnull UIViewController *)foreViewController
    NS_DESIGNATED_INITIALIZER
    NS_SWIFT_NAME(init(directorClass:timeWindow:back:fore:));

@property(nonatomic, weak, nullable) id<MDMTransitionDelegate> delegate;

@end
