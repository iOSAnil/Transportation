//
//  TubeInformationAPIContext.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

import Foundation
import Alamofire

final class NetworkManager {
    let session: Session
    
    init(session: Session? = nil) {
        let manager = Session.default
        let alamofireSession = Session(configuration: manager.session.configuration,
                                       delegate: SessionDelegate())
        self.session = session ?? alamofireSession
    }
        
    func fetchDecodable<T: Decodable>(of type: T.Type = T.self,
                                      url: String,
                                      completion: @escaping (Result<Decodable, Error>) -> Void) throws {
        guard let url = try? url.asURL() else {
            throw TransportForLondonError.inCorrectURL
        }
        
        session.request(url).responseDecodable(of: T.self) { result in
            switch (result.result) {
            case let .success(model):
                completion(.success(model))
            case .failure:
                completion(.failure(TransportForLondonError.apiFailure))
            }
        }
    }
}
