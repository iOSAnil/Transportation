//
//  TubeInformationAPIContext.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

import Foundation
import Alamofire

final class TubeInformationAPIContext: TubeInformationAPIHandler {
    func fetchTrainStationInformation(lineId: String, completion: @escaping (Result<StationModel, TransportForLondonError>) -> Void) {
        let url = TransportForLondonAPI.routeInformation(lineId: lineId).url
        let request = AF.request(url)
        
        request.responseDecodable(of: StationModel.self) { response in
            switch response.result {
            case let .success(model):
                guard let message = model.message else {
                    completion(.success(model))
                    return
                }
                completion(.failure(TransportForLondonError.serverMessage(error: message)))
            case .failure:
                completion(.failure(TransportForLondonError.apiFailure))
            }
        }
    }
    
    func fetchAllTubeInformation(completion: @escaping (Result<[TrainLineModel?], TransportForLondonError>) -> Void) {
        let url = TransportForLondonAPI.tubeLineInfo.url
        let request = AF.request(url)
        
        request.responseDecodable(of: [TrainLineModel?].self) { response in
            switch response.result {
            case let .success(model):
                return completion(.success(model))
            case .failure:
                completion(.failure(TransportForLondonError.apiFailure))
            }
        }
    }
}

enum TransportForLondonError: Error {
    case apiFailure
    case parseError
    case serverMessage(error: String)
    
    var message: String {
        switch self {
        case .apiFailure, .parseError:
            return "Something went wrong. Please try again later"
        case let .serverMessage(error: errorMessage):
            return errorMessage
        }
        
    }
}
