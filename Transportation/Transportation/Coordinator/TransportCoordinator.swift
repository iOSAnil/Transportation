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
    case backButtonTapped
    case error(String)
}

protocol TransportNavigationFlowHandler: AnyObject {
    func handleNavigationAction(_ action: TransportNavigationAction)
}

final class TransportCoordinator: Coordinator, TransportNavigationFlowHandler {
    private let apiHandler = TubeInformationAPIContext()
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
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
        show(viewController, animated: false)
    }
    
    func showTrainInformationScreen(lineId: String) {
        let viewModel = StationListViewModel(apiHandler: apiHandler, lineId: lineId, navigationDelegate: self)
        let viewController = StationListViewController(viewModel: viewModel)
        show(viewController, animated: true)
    }
    
    private func showAlertScreen(_ message: String) {
        let alert = UIAlertController(title:  StringConstant.errorTitle.localized(),
                                      message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: StringConstant.okText.localized(),
                                      style: .default, handler: { [weak self] _ in
            if self?.rootNavigationController.viewControllers.count ?? 0 > 2 {
                self?.rootNavigationController.popViewController(animated: true)
            }
        }))
        rootNavigationController.topViewController?.present(alert, animated: true, completion: nil)
    }
    
    func stop() {
        parentCoordinator?.stop()
    }
 
    func handleNavigationAction(_ action: TransportNavigationAction) {
        switch action {
        case let .trainIdentifierTapped(lineId):
            showTrainInformationScreen(lineId: lineId)
        case .backButtonTapped:
            rootNavigationController.popViewController(animated: true)
        case let .error(message):
            showAlertScreen(message)
        }
    }
}
