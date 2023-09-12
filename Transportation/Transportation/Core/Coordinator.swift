//
//  Coordinator.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get }
    var rootNavigationController: UINavigationController { get }
    func start()
    func stop()
    
    func show(_ viewController: UIViewController, animated: Bool)
    func present(_ viewController: UIViewController, animated: Bool)
}

extension Coordinator {
    func show(_ viewController: UIViewController, animated: Bool = false) {
        rootNavigationController.pushViewController(viewController, animated: animated)
    }
    
    func present(_ viewController: UIViewController, animated: Bool = false) {
        rootNavigationController.present(viewController, animated: animated)
    }
}
