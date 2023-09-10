//
//  TrainListItemViewState.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

import Foundation
import UIKit

enum TrainListItemViewState {
    case loading
    case load([TrainInformationModel])
    case error(message: String)
}

struct TrainInformationModel {
    var tubeLineId: String?
    var tubeLineName: String?
    var services: [String]
    var color: UIColor
    
    init(tubeModel: TrainLineModel) {
        self.tubeLineId = tubeModel.id
        self.tubeLineName = tubeModel.name
        self.services = tubeModel.serviceTypes?.compactMap({$0.name}).compactMap({$0}) ?? []
        self.color = TrainLine(rawValue: tubeModel.id ?? "")?.color ?? .clear
    }
}

enum TrainLine: String {
    case bakerloo
    case central
    case circle
    case district
    case hammersmithcity = "hammersmith-city"
    case jubilee
    case metropolitan
    case northern
    case piccadilly
    case victoria
    case waterlooAndCity = "waterloo-city"
    
    var color: UIColor {
        switch self {
        case .bakerloo:
            return #colorLiteral(red: 0.5375011563, green: 0.3065116405, blue: 0.1430206597, alpha: 1)
        case .central:
            return #colorLiteral(red: 0.8620022535, green: 0.1417991817, blue: 0.1232209429, alpha: 1)
        case .circle:
            return #colorLiteral(red: 0.9988922477, green: 0.8083892465, blue: 0, alpha: 1)
        case .district:
            return #colorLiteral(red: 0, green: 0.4462289214, blue: 0.1589005589, alpha: 1)
        case .hammersmithcity:
            return #colorLiteral(red: 0.8440906405, green: 0.6016427875, blue: 0.6847667694, alpha: 1)
        case .jubilee:
            return #colorLiteral(red: 0.4131166935, green: 0.4481691122, blue: 0.4690260887, alpha: 1)
        case .metropolitan:
            return #colorLiteral(red: 0.4585251808, green: 0.06324432045, blue: 0.3382344842, alpha: 1)
        case .northern:
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .piccadilly:
            return #colorLiteral(red: 0.002148355125, green: 0.09624100477, blue: 0.6581280231, alpha: 1)
        case .victoria:
            return #colorLiteral(red: 0.003172723344, green: 0.6291705966, blue: 0.8849121332, alpha: 1)
        case .waterlooAndCity:
            return #colorLiteral(red: 0.4641987681, green: 0.8164842129, blue: 0.7430990338, alpha: 1)
        }
    }
}
