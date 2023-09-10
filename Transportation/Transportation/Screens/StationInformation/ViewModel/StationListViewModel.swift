//
//  StationListViewModel.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

import Foundation
import Alamofire

final class StationListViewModel {
    private let apiHandler: TubeInformationAPIHandler
    private let lineId: String
    private (set) var publisher: Publisher<StationListViewState>
    weak var navigationDelegate: TransportNavigationFlowHandler?
    
    static var initialValue: StationListViewState = .loading

    enum Event {
        case screenAppear
        case backButtonTapped
        case errorReceived(String)
    }

    init(apiHandler: TubeInformationAPIHandler, lineId: String, navigationDelegate: TransportNavigationFlowHandler?) {
        publisher = Publisher(value: StationListViewModel.initialValue)
        self.apiHandler = apiHandler
        self.lineId = lineId
        self.navigationDelegate = navigationDelegate
    }
    
    func dispatch(event: Event) {
        switch event {
        case .screenAppear:
            fetchStationList()
        case .backButtonTapped:
            self.navigationDelegate?.handleNavigationAction(.backButtonTapped)
        case let .errorReceived(message):
            self.navigationDelegate?.handleNavigationAction(.error(message))

        }
    }
    
    private func fetchStationList() {
        apiHandler.fetchTrainStationInformation(lineId: lineId, completion: { [weak self] result in
            switch result {
            case let .success(model):
                self?.publisher.value = .load(StationList(model: model))
            case let .failure(error):
                self?.publisher.value = .error(message: error.message)
            }
        })
    }
}
