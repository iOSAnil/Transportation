//
//  MockTubeInformationAPIContext.swift
//  TransportationTests
//
//  Created by Anil Kothari on 10/09/23.
//

import XCTest
@testable import Transportation

final class MockTubeInformationAPIContext: TubeInformationAPIHandler {
    enum TestType {
        case failure
        case success
        case errorMessage
        case nilModel
    }

    let testType: TestType

    init(testType: TestType) {
        self.testType = testType
    }

    func fetchAllTubeInformation(url: String,
                                 completion: @escaping (Result<[Transportation.TrainLineModel?], Transportation.TransportForLondonError>) -> Void) {
        switch testType {
        case .success:
            do {
                let model = try "TrainList".getData().decode([Transportation.TrainLineModel?].self)
                completion(.success(model))
            } catch {
                completion(.failure(.parseError))
            }
        case .failure:
            completion(.failure(.apiFailure))
        case .errorMessage:
            completion(.success([]))
        case .nilModel:
            completion(.success([nil]))
        }
    }

    func fetchTrainStationInformation(lineId: String, completion: @escaping (Result<Transportation.StationModel?, Transportation.TransportForLondonError>) -> Void) {
        switch testType {
        case .success:
            let model: Transportation.StationModel = "victoria".load()
            completion(.success(model))
        case .failure:
            completion(.failure(.apiFailure))
        case .errorMessage:
            completion(.success(StationModel(lineId: nil, lineName: nil, stations: nil, message: "errorMessage")))
        case .nilModel:
            completion(.success(nil))
        }
    }
}

extension StationListViewState: Equatable {
    public static func == (lhs: Transportation.StationListViewState, rhs: Transportation.StationListViewState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case let (.error(messageL), .error(messageR)):
            return messageL == messageR
        case let (.load(modelL), .load(modelR)):
            return modelL.lineName == modelR.lineName
        default:
            return false
        }
    }
}

extension TrainListItemViewState: Equatable {
    public static func == (lhs: Transportation.TrainListItemViewState, rhs: Transportation.TrainListItemViewState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case let (.error(message: messageL), .error(message: messageR)):
            return messageL == messageR
        case let (.load(listL), .load(listR)):
            return listL.count == listR.count
        default:
            return false
        }
    }
}
