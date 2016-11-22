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

#import "MDMTransitionDismisser.h"
#import "MDMTransitionDismisser+Private.h"

#import "MDMTransitionController+Private.h"

@interface MDMTransitionDismisser () <UIGestureRecognizerDelegate>
@property(nonatomic, strong, readonly) NSMutableSet *nonSimultaneousGestureRecognizers;
@end

@implementation MDMTransitionDismisser

- (instancetype)initWithTransitionController:(MDMTransitionController *)controller {
  self = [super init];
  if (self) {
    _controller = controller;

    _knownGestureRecognizers = [NSMutableSet set];
    _nonSimultaneousGestureRecognizers = [NSMutableSet set];
  }
  return self;
}

#pragma mark Private

- (void)gestureRecognizerDidChange:(UIGestureRecognizer *)gestureRecognizer {
  if (gestureRecognizer.state == UIGestureRecognizerStateBegan || gestureRecognizer.state == UIGestureRecognizerStateRecognized) {
    [self.controller dismiss];
  }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
  BOOL priorityInvolved = ([self.nonSimultaneousGestureRecognizers containsObject:gestureRecognizer] || [self.nonSimultaneousGestureRecognizers containsObject:otherGestureRecognizer]);
  if (priorityInvolved) {
    return false;
  }
  BOOL bothKnown = ([self.knownGestureRecognizers containsObject:gestureRecognizer] && [self.knownGestureRecognizers containsObject:otherGestureRecognizer]);
  return bothKnown;
}

#pragma mark Public

- (void)dismissWhenGestureRecognizerBegins:(UIGestureRecognizer *)gestureRecognizer {
  [gestureRecognizer addTarget:self action:@selector(gestureRecognizerDidChange:)];

  if (gestureRecognizer.delegate == nil) {
    gestureRecognizer.delegate = self;
  }

  [self.knownGestureRecognizers addObject:gestureRecognizer];
}

- (void)disableSimultaneousRecognitionOfGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
  [self.nonSimultaneousGestureRecognizers addObject:gestureRecognizer];
}

@end
