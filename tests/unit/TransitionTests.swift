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

import XCTest
import MaterialMotionCoreAnimationFamily
import MaterialMotionTransitions

private class ChangeState: NSObject, Plan {
  func performerClass() -> AnyClass {
    return Performer.self
  }

  func copy(with zone: NSZone? = nil) -> Any {
    return ChangeState()
  }

  private class Performer: NSObject, Performing {
    let target: State
    required init(target: Any) {
      self.target = target as! State
    }

    func addPlan(_ plan: Plan) {
      target.boolean = true
    }
  }
}

private class State {
  var boolean = false
}

class TransitionTests: XCTestCase {

  func testInitialization() {
    let transition = Transition(directorClass: EmptyDirector.self,
                                timeWindow: .forward,
                                back: .init(),
                                fore: .init())
    XCTAssertNotNil(transition.backViewController)
    XCTAssertNotNil(transition.foreViewController)
    XCTAssertEqual(transition.window.currentDirection, .forward)
  }
}
