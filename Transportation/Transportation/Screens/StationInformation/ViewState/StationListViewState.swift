//
//  StationListViewState.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

import Foundation
import UIKit

enum StationListViewState {
    case loading
    case load(StationList)
    case error(message: String)
}

struct StationList {
    let lineName: String?
    var items: [StationItemViewState]
    
    init(model: StationModel) {
        if let lineName = model.lineName {
            self.lineName = String(format: StringConstant.lineStations.localized(), lineName)
        } else {
            self.lineName = StringConstant.stations.localized()
        }
        items = model.stations?.compactMap({ StationItemViewState(tubeModel: $0, id: model.lineId)   }) ?? []
    }
}

struct StationItemViewState {
    let stationName: String?
    let color: UIColor

    init(tubeModel: Station, id: String?) {
        self.stationName = tubeModel.name
        self.color = TrainLine(rawValue: id ?? "")?.color ?? .clear
    }
}
