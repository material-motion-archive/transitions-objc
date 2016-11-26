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

import UIKit
import MaterialMotionCoreAnimation
import MaterialMotionTransitions

let transitionDirectors: [TransitionDirector.Type] = [
  FadeInTransitionDirector.self,
  SlideInTransitionDirector.self
]
let cellIdentifier = "directorCell"

class ShowNavController: UINavigationController {
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
  }
}

public class AllTransitionDirectorsExampleViewController: UITableViewController {

  override public func viewDidLoad() {
    super.viewDidLoad()

    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)

    view.backgroundColor = .white
  }

  override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return transitionDirectors.count
  }

  override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    cell.textLabel?.text = NSStringFromClass(transitionDirectors[indexPath.row])
    return cell
  }

  override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let directorClass = transitionDirectors[indexPath.row]

    let viewController = UIViewController()
    viewController.view.backgroundColor = .white
    viewController.title = NSStringFromClass(directorClass)
    let navigationController = ShowNavController(rootViewController: viewController)

    viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(
      title: "Back",
      style: .done,
      target: self,
      action: #selector(didTapBack)
    )

    navigationController.mdm_transitionController.directorClass = directorClass

    present(navigationController, animated: true)
  }

  func didTapBack() {
    dismiss(animated: true)
  }
}
