//
//  TubeInformationAPIContext.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

import Foundation
import Alamofire

final class TubeInformationAPIContext: TubeInformationAPIHandler {
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager? = nil) {
        self.networkManager = networkManager ??  NetworkManager()
    }
    
    func fetchTrainStationInformation(lineId: String, completion: @escaping (Result<StationModel?, TransportForLondonError>) -> Void) {
        let urlString = TransportForLondonAPI.routeInformation(lineId: lineId).url
        do {
            try networkManager.fetchDecodable(of: StationModel.self, url: urlString) { result in
                switch result {
                case let .success(model):
                    completion(.success( model as? StationModel))
                case .failure:
                    completion(.failure(TransportForLondonError.apiFailure))
                }
            }
        } catch {
            completion(.failure(error as? TransportForLondonError ?? .inCorrectURL))
        }
    }
    
    func fetchAllTubeInformation(url: String, completion: @escaping (Result<[TrainLineModel?], TransportForLondonError>) -> Void) {
        do {
            try networkManager.fetchDecodable(of: [TrainLineModel?].self, url: url) { result in
                switch result {
                case let .success(model):
                    completion(.success( model as? [TrainLineModel?] ?? []))
                case .failure:
                    completion(.failure(TransportForLondonError.apiFailure))
                }
            }
        } catch {
            completion(.failure(error as? TransportForLondonError ?? .inCorrectURL))
        }
    }
}

extension Data {
    func decode<T: Decodable>(_ type: T.Type) throws -> T {
        let jsonDecoder = JSONDecoder()
        guard let model = try? jsonDecoder.decode(T.self, from: self) else {
            throw TransportForLondonError.parseError
        }
        return model
    }
}

enum TransportForLondonError: Error {
    case apiFailure
    case parseError
    case serverMessage(error: String)
    case inCorrectURL
    
    var message: String {
        switch self {
        case .apiFailure, .parseError:
            return "Something went wrong. Please try again later"
        case let .serverMessage(error: errorMessage):
            return errorMessage
        case .inCorrectURL:
            return ""
        }
        
    }
}
