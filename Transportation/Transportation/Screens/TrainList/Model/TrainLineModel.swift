//
//  TrainLineModel.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

import Foundation

// MARK: - TubeLineModel
struct TrainLineModel: Decodable {
    let type: String?
    let id: String?
    let name: String?
    let modeName: String?
    let serviceTypes: [ServiceType]?
}

// MARK: - ServiceType
struct ServiceType: Decodable {
    let name: String?
}
