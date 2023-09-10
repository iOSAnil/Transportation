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

extension TrainLineModel {
    static var mockList: [TrainLineModel] {
        return [
            TrainLineModel(type: "", id: "bakerloo", name: "Bakerloo", modeName: "", serviceTypes: [ServiceType(name: "Regular")]),
            TrainLineModel(type: "", id: "jubilee", name: "Jubilee", modeName: "", serviceTypes: [ServiceType(name: "Regular"), ServiceType(name: "Night")])
        ]
    }
}
