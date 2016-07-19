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

#import <objc/runtime.h>

@interface MDMTransitionController ()

- (instancetype)initWithViewController:(UIViewController *)viewController;

@property(nonatomic, weak) UIViewController *associatedViewController;

@end

@implementation MDMTransitionController

- (instancetype)initWithViewController:(UIViewController *)viewController {
  self = [super init];
  if (self) {
    _associatedViewController = viewController;
  }
  return self;
}

@end

@implementation UIViewController (MaterialMotion)

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
