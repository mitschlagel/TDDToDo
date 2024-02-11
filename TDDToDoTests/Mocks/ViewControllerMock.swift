//
//  ViewControllerMock.swift
//  TDDToDoTests
//
//  Created by Spencer Jones on 2/11/24.
//

import Foundation
import UIKit

class ViewControllerMock: UIViewController {
    var lastPresented: UIViewController?
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        lastPresented = viewControllerToPresent
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}
