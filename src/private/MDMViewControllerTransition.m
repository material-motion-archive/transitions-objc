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

#import "MDMViewControllerTransition.h"

@interface MDMViewControllerTransition () <MDMSchedulerDelegate>
@property(nonatomic, strong) MDMTransitionDirector *director;

@property(nonatomic, strong) MDMScheduler *scheduler;

@property(nonatomic, strong) id<UIViewControllerContextTransitioning> transitioningContext;
@property(nonatomic, strong) UIViewController *fromViewController;
@property(nonatomic, strong) UIViewController *toViewController;
@end

@implementation MDMViewControllerTransition

- (instancetype)initWithDirector:(nonnull MDMTransitionDirector *)director {
  self = [super init];
  if (self) {
    _director = director;
  }
  return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
  return [_director transitionDurationForUIKitAnimations];
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  // no-op because all animating is handled by the performance.
}

- (void)animationEnded:(BOOL)transitionCompleted {
  self.fromViewController.view.userInteractionEnabled = YES;
  self.toViewController.view.userInteractionEnabled = YES;

  _transitioningContext = nil;
}

#pragma mark - UIViewControllerInteractiveTransitioning

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  self.transitioningContext = transitionContext;

  UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  UIView *containerView = [transitionContext containerView];

  CGRect finalFrame = [transitionContext finalFrameForViewController:fromViewController];
  if (!CGRectIsEmpty(finalFrame)) {
    fromViewController.view.frame = finalFrame;
  }
  finalFrame = [transitionContext finalFrameForViewController:toViewController];
  if (!CGRectIsEmpty(finalFrame)) {
    toViewController.view.frame = finalFrame;
  }

  // Ensure that the destination view controller is part of the view hierarchy.
  if (self.director.initialDirection == MDMTransitionDirectionForward) {
    [containerView addSubview:toViewController.view];
  } else {
    [containerView insertSubview:toViewController.view atIndex:0];
  }
  [toViewController.view layoutIfNeeded];

  self.fromViewController = fromViewController;
  self.toViewController = toViewController;

  // Re-enabled in -animationEnded:
  self.fromViewController.view.userInteractionEnabled = NO;
  self.toViewController.view.userInteractionEnabled = NO;

  _scheduler = [MDMScheduler new];
  _scheduler.delegate = self;

  MDMTransaction *transaction = [MDMTransaction new];
  [_director setUpWithTransaction:transaction];
  [_scheduler commitTransaction:transaction];

  if (_scheduler.activityState == MDMSchedulerActivityStateIdle) {
    [self schedulerDidIdle];
  }
}

#pragma mark - MDMSchedulerDelegate

- (void)schedulerActivityStateDidChange:(nonnull MDMScheduler *)scheduler {
  if (scheduler.activityState == MDMSchedulerActivityStateIdle) {
    [self schedulerDidIdle];
  }
}

#pragma mark - Private APIs

- (void)schedulerDidIdle {
  BOOL completedInOriginalDirection = _director.currentDirection == _director.initialDirection;
  // UIKit container view controllers will replay their transition animation if the transition
  // percentage is exactly 0 or 1, so we fake being super close to these values in order to avoid
  // this flickering animation.
  if (completedInOriginalDirection) {
    [_transitioningContext updateInteractiveTransition:0.999f];
    [_transitioningContext finishInteractiveTransition];

  } else {
    [_transitioningContext updateInteractiveTransition:0.001f];
    [_transitioningContext cancelInteractiveTransition];
  }

  NSAssert(_transitioningContext, @"Transitioning context unavailable in %@::%@",
           NSStringFromClass([self class]), NSStringFromSelector(_cmd));

  // Ultimately calls -animationEnded:
  [_transitioningContext completeTransition:completedInOriginalDirection];

  _director = nil;
  _scheduler = nil;
}

@end
