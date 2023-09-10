//
//  TransportCoordinator.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

import Foundation
import UIKit

enum TransportNavigationAction {
    case trainIdentifierTapped(String)
}

protocol TransportNavigationFlowHandler: AnyObject {
    func handleNavigationAction(_ action: TransportNavigationAction)
}

final class TransportCoordinator: Coordinator, TransportNavigationFlowHandler {
    private let apiHandler = TubeInformationAPIContext()
    
    weak var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    internal var rootNavigationController: UINavigationController
    
    init(rootNavigationController: UINavigationController,
         parentCoordinator: Coordinator?) {
        self.rootNavigationController = rootNavigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        showTrainListScreen()
    }
    
    func showTrainListScreen() {
        let model = TrainListViewModel(apiHandler: apiHandler, navigationDelegate: self)
        let viewController = TrainListViewController(viewModel: model)
        rootNavigationController.pushViewController(viewController, animated: false)
    }
     
    func stop() {
        parentCoordinator?.stop()
    }
 
    func handleNavigationAction(_ action: TransportNavigationAction) {
        switch action {
        case let .trainIdentifierTapped(lineId):
            #warning("Move to station list scren")
        }
    }
}
