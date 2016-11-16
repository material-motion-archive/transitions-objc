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

/**
 A context view retriever is able to provide a context view to a transition.

 The implementor of this protocol should query the fore view controller's state that might impact
 the relevant context view for a transition.

 For example, in a photo album with a grid view that expands the tapped photo to a horizontal
 pager, paging horizontally may change the context view. In this case the grid controller should
 query the fore view controller for its currently-visible photo and return the relevant photo's
 view.
 */
NS_SWIFT_NAME(ContextViewRetriever)
@protocol MDMContextViewRetriever <NSObject>

/**
 Asks the receiver to return an existing view that contextually represents the provided fore view
 controller's current state.

 If nil is returned then no context view will be made available to the transition director.

 @param foreViewController The fore view controller of the transition.
 */
- (nullable UIView *)contextViewForTransitionWithForeViewController:(nonnull UIViewController *)foreViewController;

@end
