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

@protocol MDMReplicaControllerDelegate;

// clang-format off

/**
 A replica controller is responsible for facilitating the creation of visible replicas of
 displayable elements.

 An element might be a UIView or any other displayable object.
 */
__deprecated_msg("Use ViewReplicator instead. Deprecated in v1.1.0.")
NS_SWIFT_NAME(ReplicaController)
@interface MDMReplicaController : NSObject

#pragma mark Making replicas

/**
 Attempts to create a replica of the provided element.

 If replication fails, null is returned.

 The returned element can not be the provided element.
 */
- (nullable id)replicateElement:(nonnull id)element
    NS_SWIFT_NAME(replicate(element:))
    __deprecated_msg("Use ViewReplicator instead. Deprecated in v1.1.0.");

#pragma mark Configuration replication

/**
 The delegate is responsible for creating replica instances.

 If no delegate is provided, no replicas will be created.
 */
@property(nonatomic, weak, nullable) id<MDMReplicaControllerDelegate> delegate
    __deprecated_msg("Use ViewReplicator instead. Deprecated in v1.1.0.");

/** Disable replication for a specific element. */
- (void)disableReplicationForElement:(nonnull id)element
    NS_SWIFT_NAME(disableReplication(forElement:))
    __deprecated_msg("Use ViewReplicator instead. Deprecated in v1.1.0.");

@end

/** The replica controller delegate is responsible for creating replica elements. */
__deprecated_msg("Use ViewReplicator instead. Deprecated in v1.1.0.")
NS_SWIFT_NAME(ReplicaControllerDelegate)
@protocol MDMReplicaControllerDelegate <NSObject>

/**
 Asks the receiver to create a replica of the provided element.

 Return `element` if replication of the element is not possible or desired.
 */
- (nonnull id)replicateElement:(nonnull id)element
    NS_SWIFT_NAME(replicate(element:))
    __deprecated_msg("Use ViewReplicator instead. Deprecated in v1.1.0.");

@end

    // clang-format on
