//
//  NavigationControllerMock.swift
//  TDDToDoTests
//
//  Created by Spencer Jones on 2/10/24.
//

import Foundation
import UIKit

class NavigationControllerMock: UINavigationController {
    var lastPushedViewController: UIViewController?
    var dismissCallCount = 0
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dismissCallCount += 1
        super.dismiss(animated: flag, completion: completion)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        lastPushedViewController = viewController
        super.pushViewController(viewController, animated: animated)
    }
}
