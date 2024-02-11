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
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        lastPushedViewController = viewController
        super.pushViewController(viewController, animated: animated)
    }
}
