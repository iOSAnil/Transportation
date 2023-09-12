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
