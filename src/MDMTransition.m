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
#import "MDMTransition+Private.h"

#import "MDMTransitionDirector.h"

const NSTimeInterval MDMTransitionDirectorTransitionDurationDefault = 0.35;

@interface MDMTransition () <MDMRuntimeDelegate>

@property(nonatomic, strong) MDMRuntime *runtime;
@property(nonatomic, strong) id<MDMTransitionDirector> director;
@property(nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation MDMTransition

- (instancetype)initWithDirectorClass:(Class)directorClass
                            direction:(MDMTransitionDirection)direction
                   backViewController:(UIViewController *)backViewController
                   foreViewController:(UIViewController *)foreViewController {
  self = [super init];
  if (self) {
    _direction = direction;
    _director = [[directorClass alloc] initWithTransition:self];

    NSTimeInterval transitionDuration = MDMTransitionDirectorTransitionDurationDefault;
    if ([directorClass respondsToSelector:@selector(transitionDuration)]) {
      transitionDuration = [directorClass transitionDuration];
    }

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    _window = [[MDMTimeWindow alloc] initWithInitialDirection:direction duration:transitionDuration];
#pragma clang diagnostic pop

    _timeline = [MDMTimeline new];

    _backViewController = backViewController;
    _foreViewController = foreViewController;

    _runtime = [MDMRuntime new];
    _runtime.delegate = self;
  }
  return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
  return self.window.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  self.transitionContext = transitionContext;

  [self initiateTransition];
}

- (void)animationEnded:(BOOL)transitionCompleted {
  self.foreViewController.view.userInteractionEnabled = YES;
  self.backViewController.view.userInteractionEnabled = YES;

  self.transitionContext = nil;
}

#pragma mark - MDMSchedulerDelegate

- (void)runtimeActivityStateDidChange:(MDMRuntime *)runtime {
  if (runtime.activityState == MDMRuntimeActivityStateIdle) {
    [self runtimeDidIdle];
  }
}

#pragma mark - Private APIs

- (void)initiateTransition {
  // We use to/from here instead of back/fore simply to make it easier to work with the UIKit APIs.

  // Ensure that final frames are assigned to the view controllers.
  UIViewController *fromViewController = [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *toViewController = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  CGRect finalFrame = [self.transitionContext finalFrameForViewController:fromViewController];
  if (!CGRectIsEmpty(finalFrame)) {
    fromViewController.view.frame = finalFrame;
  }
  finalFrame = [self.transitionContext finalFrameForViewController:toViewController];
  if (!CGRectIsEmpty(finalFrame)) {
    toViewController.view.frame = finalFrame;
  }

  // Ensure that the destination view controller is part of the view hierarchy.
  UIView *containerView = [self.transitionContext containerView];
  if (self.direction == MDMTransitionDirectionForward) {
    [containerView addSubview:toViewController.view];
  } else {
    [containerView insertSubview:toViewController.view atIndex:0];
  }
  [toViewController.view layoutIfNeeded];

  // Re-enabled in -animationEnded:
  self.backViewController.view.userInteractionEnabled = NO;
  self.foreViewController.view.userInteractionEnabled = NO;

  [self.director setUp];

  if (self.runtime.activityState == MDMRuntimeActivityStateIdle) {
    [self runtimeDidIdle];
  }
}

- (void)runtimeDidIdle {
  BOOL completedInOriginalDirection = true;
  // UIKit container view controllers will replay their transition animation if the transition
  // percentage is exactly 0 or 1, so we fake being super close to these values in order to avoid
  // this flickering animation.
  if (completedInOriginalDirection) {
    [self.transitionContext updateInteractiveTransition:0.999f];
    [self.transitionContext finishInteractiveTransition];
  } else {
    [self.transitionContext updateInteractiveTransition:0.001f];
    [self.transitionContext cancelInteractiveTransition];
  }

  NSAssert(self.transitionContext, @"Transitioning context unavailable in %@::%@",
           NSStringFromClass([self class]), NSStringFromSelector(_cmd));

  // Ultimately calls -animationEnded:
  [self.transitionContext completeTransition:completedInOriginalDirection];

  self.runtime = nil;
  self.director = nil;

  [self.delegate transitionDidComplete:self];
}

- (UIView *)contextView {
  return [self.delegate contextViewForTransition:self];
}

- (UIView *)containerView {
  return [self.transitionContext containerView];
}

@end
