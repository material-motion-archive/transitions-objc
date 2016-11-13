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

import MaterialMotionRuntime

class MapDragRadius: NSObject, Plan {
  var radius: CGFloat
  var duration: TimeInterval
  var panGestureRecognizer: UIPanGestureRecognizer

  public init(_ radius: CGFloat, duration: TimeInterval, panGestureRecognizer: UIPanGestureRecognizer) {
    self.radius = radius
    self.duration = duration
    self.panGestureRecognizer = panGestureRecognizer
  }

  /** The performer that will fulfill this plan. */
  public func performerClass() -> AnyClass {
    return Performer.self
  }

  /** Returns a copy of this plan. */
  public func copy(with zone: NSZone? = nil) -> Any {
    return MapDragRadius(radius, duration: duration, panGestureRecognizer: panGestureRecognizer)
  }

  private class Performer: NSObject, Performing {
    let target: Timeline
    required init(target: Any) {
      self.target = target as! Timeline
    }

    var radius: CGFloat?
    var duration: TimeInterval?
    func addPlan(_ plan: Plan) {
      let mapDragRadius = plan as! MapDragRadius

      radius = mapDragRadius.radius
      duration = mapDragRadius.duration

      mapDragRadius.panGestureRecognizer.addTarget(self, action: #selector(handle(gesture:)))
      handle(gesture: mapDragRadius.panGestureRecognizer)
    }

    func handle(gesture: UIPanGestureRecognizer) {
      if gesture.state == .began {
        target.scrubber = TimelineScrubber()

      } else if gesture.state == .ended || gesture.state == .cancelled {
        target.scrubber = nil
      }

      if let scrubber = target.scrubber {
        let translation = gesture.translation(in: gesture.view)
        let distance = sqrt(translation.x * translation.x + translation.y * translation.y)
        scrubber.timeOffset = max(0, min(duration!, duration! * TimeInterval(distance) / TimeInterval(radius!)))
      }
    }
  }
}
