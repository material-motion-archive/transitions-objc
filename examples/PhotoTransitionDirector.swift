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

import MaterialMotionTransitions
import MaterialMotionCoreAnimationTransitions
import MaterialMotionPop
import MaterialMotionPopTransitions
import MaterialMotionDirectManipulation

import UIKit.UIGestureRecognizerSubclass

protocol PhotoTransitionContextView {
  func imageViewForTransition() -> UIImageView
}

protocol PhotoForeViewController {
  func imageViewForTransition() -> UIImageView
}

class PhotoTransitionDirector: NSObject, InteractiveTransitionDirector {

  required init(transition: Transition) {
  }

  func setUp() {
  }

  let replicator = ViewReplicator()

  var replicaImageView: UIView?
  var foreImageView: UIView?

  deinit {
    foreImageView?.isHidden = false
  }

  var transition: Transition!
  func willBeginTransition(_ transition: Transition) {
    self.transition = transition

    let fadeIn = TransitionTween("opacity",
                                 transition: transition,
                                 segment: .init(position: 0, length: 1),
                                 back: NSNumber(value: 0),
                                 fore: NSNumber(value: 1))
    fadeIn.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    transition.runtime.addPlan(fadeIn, to: transition.foreViewController.view.layer)

    if let contextView = transition.contextView as? PhotoTransitionContextView {
      let imageView = contextView.imageViewForTransition()
      let replica = replicator.replicate(view: imageView, into: transition.containerView)

      let foreView = transition.foreViewController.view!
      foreImageView = (transition.foreViewController as! PhotoForeViewController).imageViewForTransition()
      let imageSize = imageView.image!.size

      let fitScale = min(foreView.bounds.width / imageSize.width,
                         foreView.bounds.height / imageSize.height)
      let fitSize = CGSize(width: fitScale * imageSize.width, height: fitScale * imageSize.height)

      let forePosition = foreImageView!.superview!.convert(foreImageView!.center, to: transition.containerView)
      let plans = [
        TransitionSpring("bounds.size",
                         transition: transition,
                         back: replica.bounds.size,
                         fore: fitSize),
        TransitionSpring("position",
                         transition: transition,
                         back: replica.layer.position,
                         fore: forePosition),
        TransitionSpring("transform.scale",
                         transition: transition,
                         back: CGSize(width: 1, height: 1),
                         fore: CGSize(width: 1, height: 1)),
        TransitionSpring("transform.rotation.z",
                         transition: transition,
                         back: 0,
                         fore: 0)
        ]
      for plan in plans {
        transition.runtime.addPlan(plan, to: replica.layer)
      }
      foreImageView!.isHidden = true

      replicaImageView = replica
    }
  }

  func add(_ gestureRecognizer: UIGestureRecognizer) {
    ["bounds.size", "position", "transform.rotation.z", "transform.scale"]
      .map { PausesSpring($0, whileActive: gestureRecognizer) }
      .forEach { transition.runtime.addPlan($0, to: replicaImageView!.layer)}

    var plans: [(Plan, to: Any)] = []

    switch gestureRecognizer {
    case let pan as UIPanGestureRecognizer:
      plans.append((MapDragRadius(150,
                                  duration: transition.window.duration,
                                  panGestureRecognizer: pan),
                    to: transition.timeline))

      plans.append((Draggable(withGestureRecognizer: pan), to: replicaImageView!))
      plans.append((AppliesVelocity("position", onCompletionOf: pan), to: replicaImageView!.layer))

    case let rotate as UIRotationGestureRecognizer:
      plans.append((Rotatable(withGestureRecognizer: rotate), to: replicaImageView!))
      plans.append((AppliesVelocity("transform.rotation.z", onCompletionOf: rotate),
                    to: replicaImageView!.layer))

    case let pinch as UIPinchGestureRecognizer:
      plans.append((Pinchable(withGestureRecognizer: pinch), to: replicaImageView!))
      plans.append((AppliesVelocity("transform.scale", onCompletionOf: pinch),
                    to: replicaImageView!.layer))
    default:
      ()
    }

    for pair in plans {
      transition.runtime.addPlan(pair.0, to: pair.to)
    }
  }
}

// Dismissal
extension PhotoTransitionDirector: SelfDismissingTransitionDirector {
  static func willPresentForeViewController(_ foreViewController: UIViewController, dismisser: TransitionDismisser) {
    [UITapGestureRecognizer(),
     UIPanGestureRecognizer(),
     UIPinchGestureRecognizer(),
     UIRotationGestureRecognizer()].forEach {
      dismisser.dismiss(whenGestureRecognizerBegins: $0)
      foreViewController.view.addGestureRecognizer($0)
    }
  }
}
