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

#import "MDMTransitionDirector+Private.h"

@interface MDMViewControllerTransition () <MDMSchedulerDelegate>
@property(nonatomic, strong) MDMTransitionDirector *director;

@property(nonatomic, strong) MDMScheduler *scheduler;

@property(nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;
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
  self.transitionContext = transitionContext;

  [self initiateTransition];
}

- (void)animationEnded:(BOOL)transitionCompleted {
  self.fromViewController.view.userInteractionEnabled = YES;
  self.toViewController.view.userInteractionEnabled = YES;

  self.transitionContext = nil;
}

#pragma mark - MDMSchedulerDelegate

- (void)schedulerActivityStateDidChange:(nonnull MDMScheduler *)scheduler {
  if (scheduler.activityState == MDMSchedulerActivityStateIdle) {
    [self schedulerDidIdle];
  }
}

#pragma mark - Private APIs

- (void)initiateTransition {
  UIViewController *fromViewController = [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *toViewController = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  UIView *containerView = [self.transitionContext containerView];

  CGRect finalFrame = [self.transitionContext finalFrameForViewController:fromViewController];
  if (!CGRectIsEmpty(finalFrame)) {
    fromViewController.view.frame = finalFrame;
  }
  finalFrame = [self.transitionContext finalFrameForViewController:toViewController];
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

  _director.scheduler = _scheduler;

  [_director setUp];

  if (_scheduler.activityState == MDMSchedulerActivityStateIdle) {
    [self schedulerDidIdle];
  }
}

- (void)schedulerDidIdle {
  BOOL completedInOriginalDirection = _director.currentDirection == _director.initialDirection;
  // UIKit container view controllers will replay their transition animation if the transition
  // percentage is exactly 0 or 1, so we fake being super close to these values in order to avoid
  // this flickering animation.
  if (completedInOriginalDirection) {
    [_transitionContext updateInteractiveTransition:0.999f];
    [_transitionContext finishInteractiveTransition];

  } else {
    [_transitionContext updateInteractiveTransition:0.001f];
    [_transitionContext cancelInteractiveTransition];
  }

  NSAssert(_transitionContext, @"Transitioning context unavailable in %@::%@",
           NSStringFromClass([self class]), NSStringFromSelector(_cmd));

  // Ultimately calls -animationEnded:
  [_transitionContext completeTransition:completedInOriginalDirection];

  _director = nil;
  _scheduler = nil;

  [self.delegate transitionDidFinish];
}

@end
