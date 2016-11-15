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

#import <Foundation/Foundation.h>

/** A view replicator is capable of replicating UIView instances in a performant manner. */
NS_SWIFT_NAME(ViewReplicator)
@interface MDMViewReplicator : NSObject

/**
 Returns a replicated instance of the provided view.

 The replica view will have been added to the container view.

 If the original view has a superview then the replica view's position, bounds, and transform are
 updated such that the replica view's frame visually matches that of the original view's.

 The original view will have been hidden upon return.
 */
- (nonnull UIView *)replicateView:(nonnull UIView *)view
                intoContainerView:(nonnull UIView *)containerView
    NS_SWIFT_NAME(replicate(view:into:));

@end
