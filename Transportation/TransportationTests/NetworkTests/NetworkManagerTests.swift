//
//  NetworkManagerTests.swift
//  TransportationTests
//
//  Created by Anil Kothari on 10/09/23.
//

import XCTest
@testable import Transportation
@testable import Alamofire

final class NetworkManagerTests: XCTestCase {
    private var session: Session?
    private var networkManager: NetworkManager?

    override func setUpWithError() throws {
        let urlSessionConfiguration = URLSessionConfiguration.ephemeral
        urlSessionConfiguration.protocolClasses = [MockURLProtocol.self]
        session = Session(configuration: urlSessionConfiguration)
        networkManager = NetworkManager(session: session)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNetworkManagerSuccess() {
        setMockSuccessProtocol()
        let urlString = TransportForLondonAPI.routeInformation(lineId: "victoria").url
        let expectation = XCTestExpectation(description: "tube line id api should be success")

        try? networkManager?.fetchDecodable(of: StationModel.self, url: urlString, completion: { result in
            switch result {
            case let .success(stationModel):
                guard let model = stationModel as? StationModel else {
                    XCTFail("model should be of type StationModel")
                    return
                }
                XCTAssertEqual(model.lineName, "Victoria")
                XCTAssertEqual(model.stations?.count, 16)
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        })

        wait(for: [expectation], timeout: TimeConstant.standardExpectationTimeout)
    }

    func testNetworkManagerFailure() {
        setMockHttpFailureProtocol()
        let urlString = TransportForLondonAPI.routeInformation(lineId: "victoria").url
        let expectation = XCTestExpectation(description: "tube line id api should be fail")

        try? networkManager?.fetchDecodable(of: StationModel.self, url: urlString, completion: { result in
            switch result {
            case .success:
                XCTFail("api should fail")
            case .failure:
                expectation.fulfill()
            }
        })

        wait(for: [expectation], timeout: TimeConstant.standardExpectationTimeout)
    }

    func testNetworkManagerFailureWithInCorrectURL() {
        setMockHttpFailureProtocol()
        let urlString = ""
        let expectation = XCTestExpectation(description: "tube line id api should be fail")
        do {
            try NetworkManager().fetchDecodable(of: StationModel.self,
                                                 url: urlString,
                                                 completion: { _ in
                XCTFail("api should fail")
            })
        } catch {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: TimeConstant.standardExpectationTimeout)
    }

}

extension XCTestCase {

  func setMockSuccessProtocol() {
        MockURLProtocol.requestHandler = { request in
            guard let data = request.url?.getMockResponseFileURL().getData(),
                  let url = request.url,
                  let response = HTTPURLResponse(url: url,
                                                 statusCode: 200,
                                                 httpVersion: "1.0",
                                                 headerFields: nil) else {
                fatalError("request url, data & response should not be nil")
            }
            return (response, data)
        }
    }

    func setMockHttpFailureProtocol() {
        MockURLProtocol.requestHandler = { _ in
            guard let response = HTTPURLResponse(url: URL.defaultURL,
                                                 statusCode: 503,
                                                 httpVersion: "1.0",
                                                 headerFields: nil),
                  let data = "".data(using: .utf8) else {
                fatalError("data and response should not be nil")
            }
            return (response, data)
        }
    }

    func setMockSuccessProtocolWithNoData() {
        MockURLProtocol.requestHandler = { _ in
            guard let response = HTTPURLResponse(url: URL.defaultURL,
                                                 statusCode: 200,
                                                 httpVersion: "1.0",
                                                 headerFields: nil),
                  let data = "".data(using: .utf8) else {
                fatalError("data and response should not be nil")
            }
            return (response, data)
        }
    }

}

extension Station {
    static var mockList: [Station] {
        return [
            Station(name: "Bermondsey Underground Station", modes: ["bus", "train"], zone: "2"),
            Station(name: "Stratford Underground Station", modes: ["bus", "train"], zone: "2")
        ]
    }

    static var mockModel: Station {
        return Station(name: "Bermondsey Underground Station",
                       modes: ["bus", "train"], zone: "2")

    }
}

extension TrainLineModel {
    static var mockList: [TrainLineModel] {
        return [
            TrainLineModel(type: "", id: "bakerloo", name: "Bakerloo", modeName: "", serviceTypes: [ServiceType(name: "Regular")]),
            TrainLineModel(type: "", id: "jubilee", name: "Jubilee", modeName: "", serviceTypes: [ServiceType(name: "Regular"), ServiceType(name: "Night")])
        ]
    }
}

extension StationModel {
    static var nilModel: StationModel {
        StationModel(lineId: nil, lineName: nil, stations: nil, message: nil)
    }

    static var mockModel: StationModel {
        StationModel(lineId: "victoria", lineName: "Victoria", stations: Station.mockList, message: nil)
    }
}
