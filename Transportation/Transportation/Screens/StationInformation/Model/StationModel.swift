//
//  StationModel.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

import Foundation

// MARK: - TrainStopsModel
struct StationModel: Decodable {
    let lineId: String?
    let lineName: String?
    let stations: [Station]?
    let message: String?
}

// MARK: - Station
struct Station: Decodable {
    let name: String?
    let modes: [String]?
    let zone: String?
}

extension Station {
    static var mockList: [Station] {
        return [
            Station(name: "Bermondsey Underground Station", modes: ["bus", "train"], zone: "2"),
            Station(name: "Stratford Underground Station", modes: ["bus", "train"], zone: "2")
        ]
    }
}
