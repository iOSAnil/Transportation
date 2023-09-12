//
//  TransportForLondonAPI.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

enum TransportForLondonAPI {
    case tubeLineInfo
    case routeInformation(lineId: String)

    var url: String {
        return "\(baseURL)?\(queryString)"
    }

    var baseURL: String {
        return "\(domain)\(path)"
    }

    var queryString: String {
        let keyValuePairs = ["app_id": appId,
                             "app_key": appKey]

        let queryString = (keyValuePairs.compactMap({ (key, value) -> String in
            return "\(key)=\(value)"
        }) as Array).joined(separator: "&")

        return queryString
    }

    var domain: String {
        return "https://api.tfl.gov.uk"
    }

    var path: String {
        switch self {
        case .tubeLineInfo:
            return "/Line/Mode/tube"
        case let .routeInformation(lineId: lineId):
            return "/Line/\(lineId)/Route/Sequence/outbound"
        }
    }

    var appId: String {
        return "com.tfl"
    }

    #warning("This is demo API key only. Prod key should be injected in the app bundle by the CI/CD server during runtime")
    var appKey: String {
        return "130342c83ef347bd979ceea042cf2e0f"
    }
}
