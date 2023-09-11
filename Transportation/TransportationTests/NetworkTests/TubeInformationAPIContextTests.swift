//
//  TubeInformationAPIContextTests.swift
//  TransportationTests
//
//  Created by Anil Kothari on 10/09/23.
//

import XCTest
@testable import Transportation
@testable import Alamofire

struct TimeConstant {
    static var standardExpectationTimeout: TimeInterval = 2.0
}

final class TubeInformationAPIContextTests: XCTestCase {
    private var session: Session?
    private var networkManager: NetworkManager?

    override func setUpWithError() throws {
        let urlSessionConfiguration = URLSessionConfiguration.ephemeral
        urlSessionConfiguration.protocolClasses = [MockURLProtocol.self]
        session = Session(configuration: urlSessionConfiguration)
        networkManager = NetworkManager(session: session)
    }

    override func tearDownWithError() throws {
        session = nil
        networkManager = nil
    }

    func testStationListInformationSuccess() {
        setMockSuccessProtocol()
        let context = TubeInformationAPIContext(networkManager: networkManager)
        let expectation = XCTestExpectation(description: "tube line id api should be success")

        context.fetchTrainStationInformation(lineId: "victoria") { result in
            switch result {
            case let .success(stationModel):
                XCTAssertEqual(stationModel?.lineName, "Victoria")
                XCTAssertEqual((stationModel?.stations ?? []).count, 16)
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: TimeConstant.standardExpectationTimeout)
    }

    func testStationListInformationInCorrectURL() {
        let context = TubeInformationAPIContext()
        let expectation = XCTestExpectation(description: "Train list api should be success")

        context.fetchTrainStationInformation(lineId: "%") { result in
            switch result {
            case .success:
                XCTFail("Empty url should give error")

            case let .failure(error):
                expectation.fulfill()
                XCTAssertEqual(error.message, TransportForLondonError.inCorrectURL.message)
            }
        }
        wait(for: [expectation], timeout: TimeConstant.standardExpectationTimeout)
    }

    func testStationListInformationSuccessNoData() {
        setMockSuccessProtocolWithNoData()
        let context = TubeInformationAPIContext(networkManager: networkManager)
        let expectation = XCTestExpectation(description: "tube line id api should be success")

        context.fetchTrainStationInformation(lineId: "victoria") { result in
            switch result {
            case .success:
                XCTFail("Station list api should fail")
            case .failure:
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: TimeConstant.standardExpectationTimeout)
    }

    func testStationListInformationFailure() {
        setMockHttpFailureProtocol()
        let context = TubeInformationAPIContext(networkManager: networkManager)
        let expectation = XCTestExpectation(description: "tube line id api should be failure")

        context.fetchTrainStationInformation(lineId: "victoria") { result in
            switch result {
            case .success:
                XCTFail("Station list api should fail")
            case .failure:
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: TimeConstant.standardExpectationTimeout)
    }

    func testTrainListInformationSuccess() {
        setMockSuccessProtocol()
        let context = TubeInformationAPIContext(networkManager: networkManager)
        let expectation = XCTestExpectation(description: "Train list api should be success")

        context.fetchAllTubeInformation(url: TransportForLondonAPI.tubeLineInfo.url) { result in
            switch result {
            case let .success(stationModel):
                XCTAssertEqual(stationModel.count, 11)
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: TimeConstant.standardExpectationTimeout)
    }

    func testTrainListInformationInCorrectURL() {
        let context = TubeInformationAPIContext()
        let expectation = XCTestExpectation(description: "Train list api should be success")

        context.fetchAllTubeInformation(url: "") { result in
            switch result {
            case .success:
                XCTFail("Empty url should give error")

            case let .failure(error):
                expectation.fulfill()
                XCTAssertEqual(error.message, TransportForLondonError.inCorrectURL.message)
            }
        }
        wait(for: [expectation], timeout: TimeConstant.standardExpectationTimeout)
    }

    func testTrainListInformationFailure() {
        setMockHttpFailureProtocol()
        let context = TubeInformationAPIContext(networkManager: networkManager)
        let expectation = XCTestExpectation(description: "Train list api should be failure")

        context.fetchAllTubeInformation(url: TransportForLondonAPI.tubeLineInfo.url) { result in
            switch result {
            case .success:
                XCTFail("Api should fail")
            case .failure:
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: TimeConstant.standardExpectationTimeout)
    }

    func testTrainListInformationSuccessWithNoData() {
        setMockSuccessProtocolWithNoData()
        let context = TubeInformationAPIContext(networkManager: networkManager)
        let expectation = XCTestExpectation(description: "Train list api should be failure")

        context.fetchAllTubeInformation(url: TransportForLondonAPI.tubeLineInfo.url) { result in
            switch result {
            case .success:
                XCTFail("Api should fail")
            case .failure:
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: TimeConstant.standardExpectationTimeout)
    }
}

class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func stopLoading() { }

    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            return
        }
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
}

extension String {
    func load<T: Decodable>() -> T {
        let data: Data
        let bundle = Bundle(for: TubeInformationAPIContextTests.self)
        guard let file = bundle.url(forResource: self, withExtension: "json")
        else {
            fatalError("Couldn't find \(self) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(self) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(self) as \(T.self):\n\(error)")
        }
    }

    func getData() -> Data {
        let data: Data
        let bundle = Bundle(for: TubeInformationAPIContextTests.self)
        guard let file = bundle.url(forResource: self, withExtension: "json")
        else {
            fatalError("Couldn't find \(self) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(self) from main bundle:\n\(error)")
        }
        return data
    }
}

extension TransportForLondonAPI: CaseIterable {
    public static var allCases: [TransportForLondonAPI] = [
        .tubeLineInfo,
        .routeInformation(lineId: "victoria")
    ]
}
extension TransportForLondonAPI {
    var responseFileName: String {
        switch self {
        case let .routeInformation(lineId: lineId):
            return lineId
        case .tubeLineInfo:
            return "TrainList"
        }
    }
}

extension URL {
    static var defaultURL: URL {
        guard let url = URL(string: "https://www.google.com") else {
            fatalError("url should not be nil")
        }
        return url
    }

    func getMockResponseFileURL() -> String {
        for api in TransportForLondonAPI.allCases {
            if self.absoluteString.hasPrefix(api.baseURL) {
                return api.responseFileName
            }
        }
        fatalError("file name should be present")
    }
}

// extension TransportForLondonError: Equatable {
//    public static func == (lhs: TransportForLondonError, rhs: TransportForLondonError) -> Bool {
//        switch (lhs, rhs) {
//        case (.apiFailure, .apiFailure),
//            (.parseError, .parseError),
//            (.inCorrectURL, .inCorrectURL):
//            return true
//        case let (.serverMessage(error: errorMessageL), .serverMessage(error: errorMessageR)):
//            return errorMessageL == errorMessageR
//        default:
//            return false
//        }
//    }
// }
