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

#import "MDMTransitionContextViewRetriever.h"
#import "MDMTransitionContextViewRetriever+Private.h"

id<MDMTransitionContextViewRetriever> MDMTransitionContextViewRetrieverForViewController(UIViewController *viewController) {
  const SEL retrievalSelector = @selector(contextViewForTransitionWithForeViewController:);

  // Get the view retriever by walking up the source view controller hierarchy until we find one
  // that conforms to ODETransitionContextViewRetriever.
  for (UIViewController *iterator = viewController;
       iterator;
       iterator = viewController.parentViewController) {
    if ([viewController respondsToSelector:retrievalSelector]) {
      return (id<MDMTransitionContextViewRetriever>)iterator;
    }
  }

  // Haven't found the view retriever yet, let's search the children.
  NSMutableArray *queue = [NSMutableArray arrayWithArray:viewController.childViewControllers];

  // Breadth-first search of the view controller children
  while (queue.count > 0) {
    UIViewController *childViewController = [queue firstObject];
    if ([childViewController respondsToSelector:retrievalSelector]) {
      return (id<MDMTransitionContextViewRetriever>)childViewController;
    }
    [queue removeObjectAtIndex:0];

    NSArray *childViewControllers = childViewController.childViewControllers;

    if ([childViewController isKindOfClass:[UINavigationController class]]) {
      // Prefer the top-most view controller.
      childViewControllers = @[ [(UINavigationController *)childViewController topViewController] ];
    }

    [queue addObjectsFromArray:childViewControllers];
  }

  return nil;
}
