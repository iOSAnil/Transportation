//
//  TubeInformationAPIHandler.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

import Foundation

protocol TubeInformationAPIHandler {
    func fetchAllTubeInformation(completion: @escaping (Result<[TrainLineModel?], TransportForLondonError>) -> Void)
    func fetchTrainStationInformation(lineId: String,
                                      completion: @escaping (Result<StationModel, TransportForLondonError>) -> Void)
}
