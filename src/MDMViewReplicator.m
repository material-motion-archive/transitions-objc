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

#import "MDMViewReplicator.h"

@implementation MDMViewReplicator {
  NSMutableSet *_replicatedViews;
  NSMutableSet *_replicaViews;
}

- (void)dealloc {
  for (UIView *view in _replicatedViews) {
    view.hidden = false;
  }

  for (UIView *view in _replicaViews) {
    [view removeFromSuperview];
  }
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _replicatedViews = [NSMutableSet set];
    _replicaViews = [NSMutableSet set];
  }
  return self;
}

// TODO: Expose for sub-classing or find a reasonable delegate pattern.
- (nullable UIView *)workingReplicaForView:(nonnull UIView *)view {
  return nil;
}

- (nonnull UIView *)replicateView:(nonnull UIView *)view
                intoContainerView:(nonnull UIView *)containerView {
  UIView *copiedView = [self workingReplicaForView:view];

  if (copiedView == nil) {
    if ([view isKindOfClass:[UIImageView class]]) {
      copiedView = [self duplicatedImageForImageView:(UIImageView *)view];

    } else if ([view isKindOfClass:[UILabel class]]) {
      copiedView = [self duplicatedLabelForLabel:(UILabel *)view];
    }
  }

  // TODO: Need to get this hint from outside.
  const BOOL canSnapshot = false;

  if (copiedView) {
    // Duplicate UIView properties
    copiedView.clipsToBounds = view.clipsToBounds;
    copiedView.backgroundColor = view.backgroundColor;
    copiedView.alpha = view.alpha;
    copiedView.opaque = view.opaque;
    copiedView.clearsContextBeforeDrawing = view.clearsContextBeforeDrawing;
    copiedView.hidden = view.hidden;
    copiedView.contentMode = view.contentMode;
    if ([view respondsToSelector:@selector(maskView)]) {
      copiedView.maskView = view.maskView;
    }
    copiedView.tintColor = view.tintColor;
    copiedView.userInteractionEnabled = view.userInteractionEnabled;

  } else if (canSnapshot) {
    // Snapshot the view exactly as it was in the last screen update.
    copiedView = [view snapshotViewAfterScreenUpdates:NO];

  } else {  // The view hasn't been rendered yet, so we forcefully draw it.
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *copied = UIGraphicsGetImageFromCurrentImageContext();
    copiedView = [[UIImageView alloc] initWithImage:copied];
    UIGraphicsEndImageContext();
  }

  copiedView.layer.borderColor = view.layer.borderColor;
  copiedView.layer.borderWidth = view.layer.borderWidth;
  copiedView.layer.cornerRadius = view.layer.cornerRadius;
  copiedView.layer.shadowColor = view.layer.shadowColor;
  copiedView.layer.shadowOffset = view.layer.shadowOffset;
  copiedView.layer.shadowOpacity = view.layer.shadowOpacity;
  copiedView.layer.shadowPath = view.layer.shadowPath;
  copiedView.layer.shadowRadius = view.layer.shadowRadius;

  if (view.superview != nil) {
    copiedView.center = [view.superview convertPoint:view.center toView:containerView];
    copiedView.bounds = view.bounds;
    copiedView.transform = view.transform;
  }
  [containerView addSubview:copiedView];
  view.hidden = true;

  [_replicatedViews addObject:view];
  [_replicaViews addObject:copiedView];

  return copiedView;
}

- (UIImageView *)duplicatedImageForImageView:(UIImageView *)imageView {
  UIImageView *copiedImageView = [UIImageView new];

  copiedImageView.image = imageView.image;
  copiedImageView.highlightedImage = imageView.highlightedImage;

  copiedImageView.animationImages = imageView.animationImages;
  copiedImageView.highlightedAnimationImages = imageView.highlightedAnimationImages;
  copiedImageView.animationDuration = imageView.animationDuration;
  copiedImageView.animationRepeatCount = imageView.animationRepeatCount;

  return copiedImageView;
}

- (UILabel *)duplicatedLabelForLabel:(UILabel *)label {
  UILabel *copiedLabel = [UILabel new];

  if (label.attributedText) {
    copiedLabel.attributedText = label.attributedText;
  } else {
    copiedLabel.text = label.text;
  }

  copiedLabel.font = label.font;
  copiedLabel.textColor = label.textColor;
  copiedLabel.shadowColor = label.shadowColor;
  copiedLabel.shadowOffset = label.shadowOffset;
  copiedLabel.textAlignment = label.textAlignment;
  copiedLabel.lineBreakMode = label.lineBreakMode;
  copiedLabel.highlightedTextColor = label.highlightedTextColor;
  copiedLabel.enabled = label.enabled;
  copiedLabel.numberOfLines = label.numberOfLines;
  copiedLabel.adjustsFontSizeToFitWidth = label.adjustsFontSizeToFitWidth;
  copiedLabel.baselineAdjustment = label.baselineAdjustment;
  copiedLabel.minimumScaleFactor = label.minimumScaleFactor;
  copiedLabel.preferredMaxLayoutWidth = label.preferredMaxLayoutWidth;

  return copiedLabel;
}

@end
