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

#import "MDMTransitionController.h"

#import "MDMTransitionDirector+Private.h"
#import "MDMViewControllerTransition.h"

#import <objc/runtime.h>

@interface MDMTransitionController ()

- (instancetype)initWithViewController:(UIViewController *)viewController;

@property(nonatomic, weak) UIViewController *associatedViewController;
@property(nonatomic, strong) MDMViewControllerTransition *transition;

@end

@implementation MDMTransitionController

- (instancetype)initWithViewController:(UIViewController *)viewController {
  self = [super init];
  if (self) {
    _associatedViewController = viewController;
  }
  return self;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
  [self prepareForTransitionWithfromViewController:source
                                fromViewController:presenting
                                  toViewController:presented
                                         direction:MDMTransitionDirectionPresent];
  return _transition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
  // The source is sadly lost by the time we get to dismissing the view controller, so we do our
  // best to infer what the source might have been.
  //
  // If the presenting view controller is a nav controller it's pretty likely that the view
  // controller was presented from its last view controller. Making this assumption is generally
  // harmless and only affects the view retriever search (by starting one view controller lower than
  // we otherwise would by using the navigation controller as the source).
  UIViewController *fromViewController = dismissed.presentingViewController;
  if ([fromViewController isKindOfClass:[UINavigationController class]]) {
    UINavigationController *navController = (UINavigationController *)fromViewController;
    fromViewController = [navController.viewControllers lastObject];
  }
  [self prepareForTransitionWithfromViewController:fromViewController
                                fromViewController:dismissed
                                  toViewController:dismissed.presentingViewController
                                         direction:MDMTransitionDirectionDismiss];
  return _transition;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
  if (animator == _transition) {
    return _transition;
  }
  return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
  if (animator == _transition) {
    return _transition;
  }
  return nil;
}

#pragma mark - Private APIs

- (void)prepareForTransitionWithfromViewController:(UIViewController *)fromViewController
                                fromViewController:(UIViewController *)fromViewController
                                  toViewController:(UIViewController *)toViewController
                                         direction:(MDMTransitionDirection)direction {
  // Dismissing while we're in another transition is fine.
  if (direction == MDMTransitionDirectionDismiss) {
    _transition = nil;
  }
  NSAssert(!_transition, @"Transition already active!");

  if (self.directorClass) {
    MDMTransitionDirector *director = [[self.directorClass alloc] initWithInitialDirection:direction
                                                                        fromViewController:fromViewController
                                                                          toViewController:toViewController];
    _transition = [[MDMViewControllerTransition alloc] initWithDirector:director];
  }
}

@end

@implementation UIViewController (MaterialMotionTransitions)

- (MDMTransitionController *)mdm_transitionController {
  const void *associatedObjectKey = @selector(mdm_setTransitionController:);
  MDMTransitionController *transitionController = objc_getAssociatedObject(self, associatedObjectKey);
  if (!transitionController) {
    transitionController = [[MDMTransitionController alloc] initWithViewController:self];
    [self mdm_setTransitionController:transitionController];
  }
  return transitionController;
}

#pragma mark - Private APIs

- (void)mdm_setTransitionController:(MDMTransitionController *)transitionController {
  MDMTransitionController *existingController = objc_getAssociatedObject(self, _cmd);
  id<UIViewControllerTransitioningDelegate> delegate = self.transitioningDelegate;
  if (existingController == delegate) {
    self.transitioningDelegate = nil;
  }

  objc_setAssociatedObject(self, _cmd, transitionController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

  if (!delegate) {
    self.transitioningDelegate = transitionController;
  }
}

@end
