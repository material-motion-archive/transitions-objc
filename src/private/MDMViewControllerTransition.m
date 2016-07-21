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
@property(nonatomic, strong) UIViewController *leftViewController;
@property(nonatomic, strong) UIViewController *rightViewController;
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
  _leftViewController.view.userInteractionEnabled = YES;
  _rightViewController.view.userInteractionEnabled = YES;

  UIViewController *dismissedViewController = nil;
  if (_director.initialDirection == _director.currentDirection && _director.initialDirection == MDMTransitionDirectionToTheLeft) {
    dismissedViewController = _rightViewController;
  }

  _transitioningContext = nil;
}

#pragma mark - UIViewControllerInteractiveTransitioning

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  _transitioningContext = transitionContext;

  UIViewController *leftViewController = [transitionContext viewControllerForKey:
                                                                ((_director.initialDirection == MDMTransitionDirectionToTheRight)
                                                                     ? UITransitionContextFromViewControllerKey
                                                                     : UITransitionContextToViewControllerKey)];
  UIViewController *rightViewController = [transitionContext viewControllerForKey:
                                                                 ((_director.initialDirection == MDMTransitionDirectionToTheRight)
                                                                      ? UITransitionContextToViewControllerKey
                                                                      : UITransitionContextFromViewControllerKey)];
  UIView *containerView = [transitionContext containerView];

  CGRect finalFrame = [transitionContext finalFrameForViewController:leftViewController];
  if (!CGRectIsEmpty(finalFrame)) {
    leftViewController.view.frame = finalFrame;
  }
  finalFrame = [transitionContext finalFrameForViewController:rightViewController];
  if (!CGRectIsEmpty(finalFrame)) {
    rightViewController.view.frame = finalFrame;
  }

  UIViewController *destinationViewController =
      [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  if (destinationViewController == rightViewController) {
    [containerView addSubview:destinationViewController.view];
  } else {
    [containerView insertSubview:destinationViewController.view atIndex:0];
  }
  [destinationViewController.view layoutIfNeeded];

  _leftViewController = leftViewController;
  _rightViewController = rightViewController;

  // Re-enabled in -animationEnded:
  _leftViewController.view.userInteractionEnabled = NO;
  _rightViewController.view.userInteractionEnabled = NO;

  _scheduler = [MDMScheduler new];
  _scheduler.delegate = self;

  MDMTransaction *transaction = [MDMTransaction new];
  [_director setUp:transaction];
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
