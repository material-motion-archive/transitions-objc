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
import MaterialMotionTransitions

class TransitionTests: XCTestCase {

  var window: UIWindow! = nil

  override func setUp() {
    super.setUp()

    window = UIWindow()
    window.rootViewController = UIViewController()
    window.rootViewController!.view.backgroundColor = .blue
    window.makeKeyAndVisible()
    window.layer.speed = 100
  }

  //MARK: - No director

  func testNoDirectorPresentTransition() {
    let toPresent = UIViewController()
    toPresent.view.backgroundColor = .red

    let _ = toPresent.mdm_transitionController

    let expect = expectation(description: "Did present")
    window.rootViewController!.present(toPresent, animated: true) {
      expect.fulfill()
    }
    waitForExpectations(timeout: 1)
  }

  func testNoDirectorDismissTransition() {
    let toPresent = UIViewController()
    toPresent.view.backgroundColor = .red

    let _ = toPresent.mdm_transitionController

    let expect = expectation(description: "Did present")
    window.rootViewController!.present(toPresent, animated: false)
    toPresent.dismiss(animated: true) {
      expect.fulfill()
    }
    waitForExpectations(timeout: 1)
  }

  //MARK: - Simple director

  func testSimpleDirectorPresentTransition() {
    let toPresent = UIViewController()
    toPresent.view.backgroundColor = .red

    toPresent.mdm_transitionController.directorClass = EmptyDirector.self

    let expect = expectation(description: "Did present")
    window.rootViewController!.present(toPresent, animated: true) {
      expect.fulfill()
    }
    waitForExpectations(timeout: 1)
  }

  // Litmus test for vanilla UIKit transitions
  func testBasicUIKitTransition() {
    let toPresent = UIViewController()
    toPresent.view.backgroundColor = .red

    let expect = expectation(description: "Did present")
    window.rootViewController!.present(toPresent, animated: true) {
      expect.fulfill()
    }
    waitForExpectations(timeout: 1)
  }
}

class EmptyDirector: TransitionDirector {
}
