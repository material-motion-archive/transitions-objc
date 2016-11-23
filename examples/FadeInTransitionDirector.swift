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

class FadeInTransitionDirector: NSObject, SelfDismissingTransitionDirector {

  required init(transition: Transition) {
  }

  func setUp() {
  }

  func willBeginTransition(_ transition: Transition) {
    let fadeIn = TransitionTween("opacity",
                                 transition: transition,
                                 segment: .init(position: 0, length: 1),
                                 back: NSNumber(value: 0),
                                 fore: NSNumber(value: 1))
    fadeIn.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    transition.runtime.addPlan(fadeIn, to: transition.foreViewController.view.layer)
  }

  static func willPresentForeViewController(_ foreViewController: UIViewController,
                                            dismisser: TransitionDismisser) {
    let tap = UITapGestureRecognizer()
    foreViewController.view.addGestureRecognizer(tap)

    // Dismiss the presented view controller when tapped.
    dismisser.dismiss(whenGestureRecognizerBegins: tap)
  }
}
