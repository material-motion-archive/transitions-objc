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

class SlideInTransitionDirector: NSObject, TransitionDirector {

  let transition: Transition
  required init(transition: Transition) {
    self.transition = transition
  }

  func setUp() {
    let midY = Double(transition.foreViewController.view.layer.position.y)
    let height = Double(transition.foreViewController.view.bounds.height)
    let slide = TransitionTween("position.y",
                                transition: transition,
                                segment: .init(position: 0, length: 1),
                                back: NSNumber(value: midY + height),
                                fore: NSNumber(value: midY))
    slide.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    transition.runtime.addPlan(slide, to: transition.foreViewController.view.layer)
  }
}
