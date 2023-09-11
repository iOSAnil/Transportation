//
//  TrainListViewModel.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

import Foundation
import Alamofire

final class TrainListViewModel {
    private let apiHandler: TubeInformationAPIHandler
    var publisher: Publisher<TrainListItemViewState>?
    weak var navigationDelegate: TransportNavigationFlowHandler?
    
    private static var initialState: TrainListItemViewState = .loading

    enum Event {
        case screenAppear
        case tubeLineTapped(id: String?)
    }

    init(apiHandler: TubeInformationAPIHandler, navigationDelegate: TransportNavigationFlowHandler?) {
        publisher = Publisher(value: TrainListViewModel.initialState)
        self.apiHandler = apiHandler
        self.navigationDelegate = navigationDelegate
    }
    
    func dispatch(event: Event) {
        switch event {
        case .screenAppear:
            fetchTubeLinesData()
        case let .tubeLineTapped(id):
            moveToScreenWithTrain(id: id)
        }
    }
    
    private func moveToScreenWithTrain(id: String?) {
        guard let tubeLineId = id, !tubeLineId.isEmpty else {
            debugPrint("tubeLineId is nil or empty")
            return
        }
        self.navigationDelegate?.handleNavigationAction(.trainIdentifierTapped(tubeLineId))
     }
    
    private func fetchTubeLinesData() {
        apiHandler.fetchAllTubeInformation(url: TransportForLondonAPI.tubeLineInfo.url) { [weak self] result in
            switch result {
            case let .success(model):
                let list = model.compactMap({$0})
                let trainModelList = list.map({ TrainInformationModel(tubeModel: $0)})
                self?.publisher?.value = .load(trainModelList)
            case let .failure(error):
                self?.publisher?.value = .error(message: error.message)
            }
        }
    }
}
