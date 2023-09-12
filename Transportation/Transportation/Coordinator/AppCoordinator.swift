//
//  AppCoordinator.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var rootNavigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    let window: UIWindow
    
    init(window: UIWindow) {
        rootNavigationController = UINavigationController()
        self.window = window
        self.window.rootViewController = rootNavigationController
        self.window.makeKeyAndVisible()
    }

    func start() {
        startTransportCoordinator()
    }
    
    func startTransportCoordinator() {
        let coordinator = TransportCoordinator(rootNavigationController: rootNavigationController,
                                               parentCoordinator: nil)
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func stop() {
        // To be written at all the child coordinator to stop & remove from container
    }
}
